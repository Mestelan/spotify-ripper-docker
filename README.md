> A Debian Stretch (slim) image with python, pip, libspotify and spotify-ripper

## Prereqs
1. Place your libspotify appkey in the directory you're going to build from
2. Modify the config if needed

## Installation
1. `git clone https://github.com/thibmaek/spotify-ripper-docker`
2. `docker build -t spotify-ripper .`
3. `docker run -name spotify-ripper -d spotify-ripper`
