# grab deps
FROM ubuntu:20.04 AS corelibs
MAINTAINER tenlilnet

ENV DEBIAN_FRONTEND=noninteractive

## build tools
RUN apt-get update
RUN apt-get install -y git cmake build-essential libluajit-5.1-dev libmysqlclient-dev libboost-system-dev libboost-iostreams-dev libboost-filesystem-dev libpugixml-dev libcrypto++-dev libfmt-dev libboost-date-time-dev

## devel tools
RUN apt-get install -y vim curl wget net-tools telnet netcat iputils-ping

# static image
FROM corelibs AS coresrc
ARG TFS_REPOSITORY
ENV TFS_REPOSITORY $TFS_REPOSITORY
ARG TFS_REPOSITORY_BRANCH
ENV TFS_REPOSITORY_BRANCH $TFS_REPOSITORY_BRANCH
ARG TFS_BUILD_DATE
ENV TFS_BUILD_DATE $TFS_BUILD_DATE

WORKDIR /otserv
RUN git clone --branch $TFS_REPOSITORY_BRANCH $TFS_REPOSITORY

# building
FROM coresrc AS builder
WORKDIR /otserv/forgottenserver
RUN mkdir build && cd build && cmake .. && make && \
    mv tfs ..

# workspace
FROM builder AS workspace

## copying local config
COPY files/data /otserv/forgottenserver/data
COPY files/src /otserv/forgottenserver/src
COPY env/config.lua /otserv/forgottenserver

## crazy workaround ISSUE#3270@DOCKER
RUN mkdir -p /otserv/local
RUN chmod 0750 /otserv/local

## preparing user
RUN useradd otserv
RUN chmod -R +rw /otserv
RUN chown -R otserv:otserv /otserv

## loading scripts
COPY scripts/tfs_waiter.sh /usr/local/bin
COPY scripts/tfs_entrypoint.sh /usr/local/bin
COPY scripts/tfs_runner.sh /usr/local/bin
RUN chmod +x /usr/local/bin/tfs_*

## preparing instance
USER otserv
WORKDIR /otserv/local
VOLUME /otserv/local

## default to user
EXPOSE 7171 7172

## running
CMD tfs_entrypoint.sh && timeout $TFS_WAIT_TIME tfs_waiter.sh && tfs_runner.sh