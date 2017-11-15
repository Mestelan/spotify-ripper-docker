FROM debian:stretch-slim
AUTHOR "Thibault Maekelbergh"

ARG DEBIAN_FRONTEND=noninteractive

# Install packages
RUN apt-get update -qy && apt-get upgrade -qy
RUN apt-get install wget lame build-essential libffi-dev python-pip python-dev python3-dev libffi-dev -y

# Download libspotify & compile it
RUN wget https://developer.spotify.com/download/libspotify/libspotify-12.1.51-Linux-x86_64-release.tar.gz && \
	tar xvf libspotify-12.1.51-Linux-x86_64-release.tar.gz && \
  rm -f libspotify-12.1.51-Linux-x86_64-release.tar.gz && \
	cd libspotify-12.1.51-Linux-x86_64-release && \
	make install prefix=/usr/local

# Install a fork of spotify-ripper
RUN pip install spotify-ripper-morgaroth

# Link our download location to /data in the container
VOLUME ["/data"]

# Copy needed files for spotify-ripper
ADD ./spotify_appkey.key /root/.spotify-ripper/spotify_appkey.key
ADD ./config.ini /root/.spotify-ripper/config.ini
