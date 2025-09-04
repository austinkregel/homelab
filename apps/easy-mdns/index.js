import { Bonjour } from 'bonjour-service';
import fs from 'fs';
import os from 'os';
import { execSync } from 'child_process';
import { parse } from "csv-parse/sync";
import http from 'http';
import https from 'https';
import path from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

// -------------------------------------------------------------
// Configuration
// -------------------------------------------------------------
const NODE_NAME = process.env.NODE_NAME || os.hostname();
const STATUS_FILE = process.env.STATUS_FILE || '/tmp/cluster_health_status.json';
const HEARTBEAT_TIMEOUT = parseInt(process.env.HEARTBEAT_TIMEOUT || '90');
const DISCORD_WEBHOOK_URL = 'https://discord.com/api/webhooks/1399042869163200512/bzT8Oha34Bjix8vlLc3Hq_jjDm9cTl-l1g67FxrPfAahw8zCe_58bycbEDmh1FHafmXp';
let SERVICES = {};

function fetch(url, timeout = 5000) {
  return new Promise((resolve) => {
    const isHttps = url.startsWith('https');
    const lib = isHttps ? https : http;
    const req = lib.get(url, { timeout }, (res) => {
      resolve(res.statusCode === 200);
    });
    req.on('error', () => resolve(false));
    req.on('timeout', () => {
      req.destroy();
      resolve(false);
    });
  });
}

function writeStatusFile(data) {
  fs.writeFileSync(STATUS_FILE, JSON.stringify(data, null, 2));
}

function sendPushNotification(message) {
  const payload = JSON.stringify({ content: message });
  const options = new URL(DISCORD_WEBHOOK_URL);
  options.method = 'POST';
  options.headers = {
      'Content-Type': 'application/json',
      'Content-Length': Buffer.byteLength(payload)
  };
  const req = https.request(options, (res) => {
      if (res.statusCode < 300) console.log(`[DISCORD] ${message}`);
  });
  req.on('error', (err) => console.error('[ERROR] Discord webhook failed:', err));
  req.write(payload);
  req.end();
}

const instance = new Bonjour();


let previousServiceStates = {};

const runStatusCheck = async () => {
    console.log(`[INFO] Running health check for node: ${NODE_NAME}`);

    const networkOutput = JSON.parse(execSync("docker network ls --format='{{json .}}' | grep homelab_internal", { encoding: 'utf-8' }));
    const networkInspection = JSON.parse(execSync("docker inspect " +networkOutput.ID +" --format='{{json .}}' | grep homelab_internal", { encoding: 'utf-8' }));

    let containers = Object.keys(networkInspection?.Containers);
    const fullList = containers.map(containerId => {
        const inspection = JSON.parse(execSync("docker inspect " + containerId + " --format='{{json .}}'", { encoding: 'utf-8' }));
        return inspection;
    });
    // fs.writeFileSync('./published_services.json', JSON.stringify(fullList, null, 4));

    const now = new Date();
    try {
        containers = fullList;
    } catch (e) {
        console.error('[ERROR] Could not read published_services.json:', e);
        return;
    }
    nodeStatus[NODE_NAME] = {
        timestamp: now.toISOString(),
        healthy: true,
    };
    for (const container of containers) {
        const name = container?.Name || container?.Config?.Labels?.['com.docker.compose.service'] || container?.Id;
        const state = container?.State?.Status;
        const health = container?.State?.Health?.Status;
        const healthLogs = container?.State?.Health?.Log;
        let alertMsg = '';
        let unhealthy = false;
        // Check for unhealthy, stopped, OOM, dead
        if (state === 'exited' || state === 'dead' || container?.State?.OOMKilled) {
            unhealthy = true;
            alertMsg = `[ALERT] Service '${name}' is ${state}${container?.State?.OOMKilled ? ' (OOMKilled)' : state}.`;
        } else if (health === 'unhealthy') {
            unhealthy = true;
            alertMsg = `[ALERT] Service '${name}' is unhealthy.`;
        }
        let logSnippet = '[No health logs available]';
        if (Array.isArray(healthLogs) && healthLogs.length > 0) {
            logSnippet = healthLogs.slice(-5).map(entry => {
                return `[${entry?.End}] ${entry?.Output || ''}`;
            }).join('\n');
        }

        // Only send notification if state changed
        const prev = previousServiceStates[name];
        if (unhealthy) {
            nodeStatus[NODE_NAME].healthy = false;
            previousServiceStates[name] = 'unhealthy';
        } else {
            nodeStatus[NODE_NAME].healthy = true;
            nodeStatus[NODE_NAME][name] = {
                timestamp: now.toISOString(),
                state,
                health,
            };
            console.log(`[INFO] Service '${name}' is healthy.`);
    
            previousServiceStates[name] = 'healthy';
        }

        if (!prev || prev !== previousServiceStates[name]) {
            sendPushNotification(`${alertMsg}\nRecent health logs:\n${logSnippet}`);
        }

    }
    writeStatusFile(nodeStatus);
}

let intervalForStatusCheck = setInterval(runStatusCheck, HEARTBEAT_TIMEOUT * 1000);
runStatusCheck(); // Initial run

const unPublishAndDeleteYourself = async function() {
    instance.unpublishAll(() => {
        instance.destroy();
        clearInterval(intervalForStatusCheck);
        console.log(`Killing broadcasters`)
        process.exit();
    });
};

process.on('SIGTERM', unPublishAndDeleteYourself)
process.on('SIGINT', unPublishAndDeleteYourself)