#!/bin/bash

# This is a file that I personally use to launch ZNC
# Change stuff like ports and PGID/PUID before launching anything

docker run -d --name znc -p 9001:6667 -P -e PGID=1000 -e PUID=1000 --restart=always -v ~/znc:/znc-data mijndert/znc
