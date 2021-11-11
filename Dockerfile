FROM debian:stretch-slim

ENV LANG C.UTF-8

ARG DEBIAN_FRONTEND=noninteractive

# Install packages
RUN apt-get update -qy && apt-get upgrade -qy
RUN apt-get install nano wget lame build-essential python-pip python-dev python3-dev python3-pip libffi-dev libssl-dev -y

# Download libspotify & compile it
RUN wget https://github.com/mopidy/libspotify-archive/raw/master/libspotify-12.1.51-Linux-x86_64-release.tar.gz && \
	tar xvf libspotify-12.1.51-Linux-x86_64-release.tar.gz && \
  rm -f libspotify-12.1.51-Linux-x86_64-release.tar.gz && \
	cd libspotify-12.1.51-Linux-x86_64-release && \
	make install prefix=/usr/local

# Install required tools for support for AAC (M4A container)
RUN apt-get install pkg-config automake autoconf -y && \
	wget http://ftp.br.debian.org/debian/pool/non-free/f/fdk-aac/libfdk-aac-dev_0.1.4-2+b1_amd64.deb && \
	wget http://ftp.br.debian.org/debian/pool/non-free/f/fdk-aac/libfdk-aac1_0.1.4-2+b1_amd64.deb && \
	dpkg -i libfdk-aac1_0.1.4-2+b1_amd64.deb && dpkg -i libfdk-aac-dev_0.1.4-2+b1_amd64.deb

# Compile libfdk-aac encoder
RUN wget https://github.com/nu774/fdkaac/archive/v0.6.2.tar.gz && tar xvf v0.6.2.tar.gz && \
	rm -f v0.6.2.tar.gz && cd fdkaac-0.6.2 && \
	autoreconf -i && ./configure && make install

# manually added because the statement below failed to install it as dependency
RUN pip3 install cffi>=1.0.0
# Install a fork of spotify-ripper
RUN pip3 install spotify-ripper-morgaroth

# Link our download location to /data in the container
VOLUME ["/data"]

# Copy needed files for spotify-ripper
COPY ./spotify_appkey.key /root/.spotify-ripper/spotify_appkey.key
COPY ./config.ini /root/.spotify-ripper/config.ini
