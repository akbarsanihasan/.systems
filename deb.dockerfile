FROM debian:trixie AS base

ENV DEBIAN_FRONTEND=noninteractive
ENV USER=john

RUN apt-get update -y \
    && apt-get install -y curl git \
    && apt-get install -y sudo apt-utils

RUN groupadd --gid 1001 john && \
    useradd -m -s /bin/bash john -g john && \
    echo 'john:john' | chpasswd && \
    usermod -aG wheel john && \
    echo '%wheel ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER john

WORKDIR /home/john/.dotfiles

COPY . .

RUN sudo chown -R john .
