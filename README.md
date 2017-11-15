> A Debian Stretch (slim) image with python, pip, libspotify and spotify-ripper

## Prereqs
1. Install Docker and make sure the Docker daemon is running.
2. Place your libspotify appkey in the directory you're going to build from
3. Modify the config if needed

## Installation
1. `git clone https://github.com/thibmaek/spotify-ripper-docker`
2. `docker build -t spotify-ripper .`
3. `docker run -itd -v /home/user/download:/data --name spotify-ripper spotify-ripper` (or run `./init.sh`)

## Ripping
Once the container is running, use docker exec to start ripping:

```bash
# ! Make sure to run the first exec with -u <username> -p <password> the first time.
#   Credentials get stored after the first run so you should only have to pass these flags once.

# Running this will run the output in the current terminal window
docker exec spotify-ripper spotify-ripper spotify:album:…

# Running this will run it detached in the background so you don't need to keep a terminal open
docker exec -d spotify-ripper spotify-ripper spotify:album:…
```
