## Credits
This was originally based on [@juftin's](https://github.com/juftin) [Homelab](https://github.com/juftin/homelab/) project :eyes: I have since heavily customized it for my own home lab

## Dependencies

make, and docker are hard dependencies

## How to setup

Please note, it is expected that some containers will fail after the first boot (notably anything matrix related). The exact config values will vary for each setup unless you're me, since you're not me, you're gonna have to fill in any missing spots :sweat_smile: (I'm happy to offer help in the Issues, but please don't expect me to know exactly why things don't work. Homelabs are a process, and your process _will_ be different than mine.)

```bash
make setup
make up
```
The first services up will be the proxy; the rest of the stack can take several minutes to come up and stabilize. Anything media related will take several times longer to come up, as it has to first boot gluetun to route the traffic through.

For a list of commands
```bash
make help
```

## List of services

### Git
 - [Gitlab](https://about.gitlab.com/install/) & 1 Runner (setup after Gitlab is running)

### Databases/Storage
 - MariaDB
 - Postgres
 - Meilisearch

### Access
 - [Nginx Reverse Proxy](https://nginxproxymanager.com/)
 - [Authair](https://github.com/austinkregel/aut.hair) (Authentication/OAuth Server)

 #### Media 
A stack of management tools for streaming media (music, tv, movies, books, etc.) Based on [geekau/mediastack](https://github.com/geekau/mediastack)
 - [Plex](https://www.plex.tv/)
 - [gluetun](https://github.com/qdm12/gluetun)
 - [Overseeerr](https://overseerr.dev/)
 - [Bazarr](https://www.bazarr.media/)
 - [FlareSolverr](https://github.com/FlareSolverr/FlareSolverr)
 - [Lidarr](https://lidarr.audio/)
 - [Prowlarr](https://prowlarr.com/)
 - [qBittorrent](https://www.qbittorrent.org/)
 - [Radarr](https://radarr.video/)
 - [Readarr](https://readarr.com/)
 - [Sabnzbd](https://sabnzbd.org/)
 - [Sonarr](https://sonarr.tv/)


#### Personal Apps
 - [Spork](https://github.com/austinkregel/spork/) (Web, Cron, Worker, and Websockets) A personal everything app, email client, matrix client, calendar, contacts, banking, and more.
 - [Lazy.Build](https://github.com/lazy-build/service/) (Web) A short cut to basic installers for linux; 
 - [Cannabis Consumer Information](https://github.com/austinkregel/cannabis-consumer-information) (Cron, Web, and Worker) The MichiganCannabis.Club website which scrapes the Michigan Gov website for Recalls and Safety Alerts, and provides a web interface to search for products, and view recalls and safety alerts. You can also log products you consume and get alerts if they are recalled or have a safety alert.

#### Utilities 

 - [Vito Deploy](https://github.com/vitodeploy/vito) Vito is a self-hosted web application that helps you manage your servers and deploy your PHP applications into production servers without a hassle.
 - [Prometheus](https://prometheus.io/docs/introduction/overview/) (Alert Manager, and Node Exporter)
 - [Grafana](https://grafana.com/)
 - [Redis](https://redis.io/)
 - [Sentry](https://sentry.io/welcome/) (Cron, and Worker) (based on this [docker-compopse.yml](https://gist.github.com/denji/b801f19d95b7d7910982c22bb1478f96)) Currently disabled due to the recommended install being very large and more complex than this whole project; can be enabled if you want to spend some time setting it up.
 - [Tautulli](https://tautulli.com/) monitor activity and track various statistics from your Plex server. Statistics include what has been watched, who watched it, when and where they watched it, and how it was watched. 
 - [Umami](https://umami.is/) analytics & website tracking dashboard
 - [Watchtower](https://github.com/containrrr/watchtower) automatic docker container updates
 - [Kutt](https://github.com/thedevs-network/kutt/) A link shortener with custom domains and analytics
 - [Synapse (Matrix)](https://github.com/element-hq/synapse) A matrix homeserver
