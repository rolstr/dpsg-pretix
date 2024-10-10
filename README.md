# pretix-dpsg
Developed for the Deutschen Pfadfinderschaft Sankt Georg [(DPSG)](https://www.dpsg-paderborn.de/)

# Features
- Fully containerized with `docker compose` system for the <u>Pretix Ticket Selling system</u>
- Automatic HTTPS certificate managing (initial fetching and renewable) with `caddy`
- Periodically creating a backup of named volumes with `offen/docker-volume-backup`

# Installation
> How to install the necessary external services (assume docker is installed and repo is cloned)?
## Create Docker External Network

Let Docker services connect to the host by creating an `external` network. 
```bash
docker network create external-network
```

## Cronjob for Pretix

Pretix requires a cronjob that executes once an hour.<br>
Run `crontab -e` and insert:

```bash
15,45 0-2,4-23 * * * /usr/bin/docker exec dpsg-pretix-pretix-1 pretix cron
```
### Optional 
- create systemd service for running the services  after booting

# Setup
>Where could what settings be adjusted? 

### ./Caddy/Caddyfile
- Change the Domain by which the Pretix service is called.

### .env

- Adjust the SMTP_USERNAME and SMTP_PASSWORD credentials for the SMTP Email Relay service

### docker-compose

- Pretix Service
    - Modify the SMTP_RELAYHOST domain 
    - Change the SMTP_SENDERMAIL email as the sender email that clients of the pretix ticket system will see 

### Pretix/pretix.cfg

- See for adjusting the settings the official [Pretix Configuration Website](https://docs.pretix.eu/en/latest/admin/config.html).


# First Start

```bash
cd dpsg-pretix
docker compoose up --build -d
```

The login weblink is `<domain>/control`.

The default Admin User Credentials are (change them immeditatley):
```
Username: admin@localhost
Password: admin
```

