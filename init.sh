#! /usr/bin/env bash

docker run -itd -v /home/$(whoami)/Music:/data --name spotify-ripper spotify-ripper
