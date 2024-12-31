FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    curl \
    make \
    wget \
    vim \
    unzip \
    tar \
    jq \
    netcat \
    iputils-ping \
    net-tools \
    && rm -rf /var/lib/apt/lists/*

CMD ["/bin/bash"]
