FROM ubuntu:24.04

LABEL Description="Generate XMLTV file from HDHomeRun devices"
LABEL HdHomeRunEpgXml-Source="https://github.com/andyg5000/HdHomeRunEpgXml"

ARG DEBIAN_FRONTEND=noninteractive

SHELL ["/bin/bash", "-c"]

COPY entrypoint.sh /

ENV PUID=1001 \
    GUID=1001 \
    TZ=America/New_York \
    CRON_SCHEDULE="0 4 * * *" \
    RUN_IMMEDIATELY=false    

VOLUME /app/output

WORKDIR /

RUN apt update && \
    apt-get update

RUN apt install -y makepasswd \
    python3 \
    python3-pip \
    python3.12-venv
RUN apt-get install -y cron

WORKDIR /app

ADD https://github.com/andyg5000/HdHomeRunEpgXml.git /app
RUN sed -i 's/hdhomerun.xml/\/app\/output\/hdhomerun.xml/g' hdhomerun.py
RUN python3 -m venv /app/venv
RUN /app/venv/bin/pip install urllib3

RUN rm -R /app/Docker /app/Release*

CMD [ "sh", "/entrypoint.sh" ]