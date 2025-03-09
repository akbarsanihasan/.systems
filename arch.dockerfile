FROM archlinux AS base

ENV USER=johnbtw

RUN pacman-key --init && pacman-key --populate

RUN pacman -Sy && \
    pacman -Sy --noconfirm reflector && \
    reflector --verbose --score 12 \
        --age 12 \
        --protocol https --sort rate \
        --save /etc/pacman.d/mirrorlist

RUN pacman -Sy && pacman -Sy --noconfirm sudo 

RUN groupadd --gid 1001 johnbtw && \
    useradd -m -s /bin/bash johnbtw -g johnbtw && \
    echo 'johnbtw:johnbtw' | chpasswd && \
    usermod -aG wheel johnbtw && \
    echo '%wheel ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers


USER johnbtw

WORKDIR /home/johnbtw/.dotfiles

COPY . .

RUN sudo chown -R johnbtw .
