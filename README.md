## Credits
This was originally based on [@juftin's](https://github.com/juftin) [Homelab](https://github.com/juftin/homelab/) project :eyes: I have since heavily customized it for my own home lab

## Dependencies

make, and docker are hard dependencies

## How to setup



```bash
make setup
make up
```

For a list of commands
```bash
make help
```

## List of services
 - [Gitlab](https://about.gitlab.com/install/) & 1 Runner (setup after Gitlab is running)
 - [Healthchecks](https://docs.linuxserver.io/images/docker-healthchecks/)
 - MariaDB
 - Postgres
 - Meilisearch
 - Nginx Reverse Proxy

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
 - [Aut.hair](https://github.com/austinkregel/aut.hair) 
 - [Spork](https://github.com/austinkregel/spork/) (Web, Cron, Worker, and Websockets)
 - [Lazy.Build](https://github.com/lazy-build/service/) (Web)
 - [Cannabis Consumer Information](https://github.com/austinkregel/cannabis-consumer-information) (Cron, Web, and Worker)

#### Utilities 

 - [Vito Deploy](https://github.com/vitodeploy/vito) Vito is a self-hosted web application that helps you manage your servers and deploy your PHP applications into production servers without a hassle.
 - [Prometheus](https://prometheus.io/docs/introduction/overview/) (Alert Manager, and Node Exporter)
 - [Grafana](https://grafana.com/)
 - [Redis](https://redis.io/)
 - [Sentry](https://sentry.io/welcome/) (Cron, and Worker) (based on this [docker-compopse.yml](https://gist.github.com/denji/b801f19d95b7d7910982c22bb1478f96))
 - [Tautulli](https://tautulli.com/) monitor activity and track various statistics from your Plex server. Statistics include what has been watched, who watched it, when and where they watched it, and how it was watched. 
 - [Umami](https://umami.is/) analytics & website tracking dashboard
 - [Watchtower](https://github.com/containrrr/watchtower) automatic docker container updates


## Soon
 - Synapse (Matrix)
 - Element Web
 - Matrix Postgres