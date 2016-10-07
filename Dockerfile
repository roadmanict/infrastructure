FROM debian

COPY sources.list /etc/apt/sources.list

RUN apt-get update && \
    apt-get install -y -t jessie-backports linux-base linux-image-4.7.0-0.bpo.1-amd64 && \
    apt-get install -y wget

RUN wget https://github.com/concourse/concourse/releases/download/v2.2.1/concourse_linux_amd64

RUN mv ./concourse_linux_amd64 /opt/concourse