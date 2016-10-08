FROM debian

COPY sources.list /etc/apt/sources.list

# big downloads first
RUN apt-get update && \
    apt-get install -y wget && \
    wget https://github.com/concourse/concourse/releases/download/v2.2.1/concourse_linux_amd64 && \
    mv ./concourse_linux_amd64 /opt/

RUN apt-get install -y -t jessie-backports linux-base linux-image-4.7.0-0.bpo.1-amd64 && \
    apt-get install -y postgresql postgresql-client openssh-client

RUN useradd -ms /bin/bash concourse

USER concourse
WORKDIR /home/concourse

RUN ssh-keygen -t rsa -f host_key -N '' && \
    ssh-keygen -t rsa -f worker_key -N '' && \
    ssh-keygen -t rsa -f session_signing_key -N '' && \
    cp worker_key.pub authorized_worker_keys

USER root
COPY concourse/concourse-web.service /etc/systemd/system/concourse-web.service
COPY concourse/concourse-worker.service /etc/systemd/system/concourse-worker.service
RUN systemctl daemon-reload