# HDHomeRun-epgXML Docker


# Attribution

Original script from [andyg5000/HdHomeRunEpgXml](https://github.com/andyg5000/HdHomeRunEpgXml)

# Description

Connect to your local HDHomeRun device and pull the XMLTV data from it, now in a Docker container with cron!

# Setup
`docker-compose.yml`

```
services:
  hdhomerun-epgxml:
    container_name: hdhomerun-epgxml
    image: curiouscocoon/hdhomerun-epgxml:latest
    environment:
      PUID: 1001
      GUID: 1001
      RUN_IMMEDIATELY: false
      CRON_SCHEDULE: "00 03 * * *"
      TZ: America/New_York
    volumes:
      - ./hdhomerun-epgxml/app/output:/app/output
    network_mode: host # Required
    restart: no
```

## Variables

`PUID`: The user ID you want the `hdhomerun.xml` file to be owned by

`GUID`: The group ID you want the `hdhomerun.xml` file to be owned by

`RUN_IMMEDIATELY`: Whether or not the script should be run as soon as the container is started. Otherwise, it will only run on the cron schedule

`CRON_SCHEDULE`: The time and interval, in cron format, you want the script to be run at.
* It's recommended to run only once per day

## Volumes

`/app/output`: Where the `hdhomerun.xml` file will be saved

# Usage

1) Spin up the container
2) Wait for the script to run automatically
3) ???
4) Profit

# Notes

Unfortunately, I couldn't find a way to make the script not run as `root` user from within cron inside the Docker container, no matter what I tried. As a workaround, `root` simply `chown`s the file after it's been saved.