FROM ubuntu:20.04

ENV DEBIAN_FRONTEND="noninteractive"

LABEL maintainer "pr0d1r2@gmail.com"
LABEL update "2022/02/14"

RUN apt-get update
RUN apt-get install -y wget

COPY . /tmp/unmineable-mine
COPY docker/command-stub.sh /usr/bin/systemctl

WORKDIR /tmp/unmineable-mine
RUN bash ./install.sh
