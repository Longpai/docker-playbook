#!/bin/bash
set -eu

image=$1
echo "start process"
if [ -d "/usr/local/xdxct" ]; then
    exit 0
fi

docker pull $image

docker run --privileged -it --pid=host \
-v /run/xdxct:/run/xdxct \
-v /etc/docker:/etc/docker \
-v /usr/local/xdxct:/usr/local/xdxct \
-v /var/run:/var/run \
--env ROOT=/usr/local/xdxct \
"$image" -c "xdxct-toolkit -n"
