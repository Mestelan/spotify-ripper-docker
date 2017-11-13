FROM debian:stretch-slim
COPY ./ ~/.spotify-ripper/

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get upgrade -y
RUN apt-get install wget lame build-essential libffi-dev python python-dev python-pip -y

RUN pip install spotify-ripper

RUN wget https://developer.spotify.com/download/libspotify/libspotify-12.1.51-Linux-x86_64-release.tar.gz
RUN tar xvf libspotify-12.1.51-Linux-x86_64-release.tar.gz
