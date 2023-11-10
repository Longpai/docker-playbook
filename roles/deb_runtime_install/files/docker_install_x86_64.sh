#!/bin/bash
set -eu

cd /tmp
tar -zxf docker-20.10.21-amd64.tgz
sudo mv docker/* /usr/bin

# tgz file list
# containerd  containerd-shim  containerd-shim-runc-v2  ctr
# docker  dockerd  docker-init  docker-proxy  runc

# wget 10.211.10.15:5020/docker.service
# sudo mv docker.service /usr/lib/systemd/system
# sudo chmod +x /usr/lib/systemd/system/docker.service
# sudo systemctl daemon-reload

# wget 10.211.10.15:5020/daemon.json
# sudo mkdir -p /etc/docker
# sudo mv daemon.json /etc/docker/daemon.json

# sudo systemctl daemon-reload
# sudo systemctl start docker

# sudo systemctl enable docker

# sudo groupadd docker
# sudo gpasswd -a cqjcdl docker

# wget 10.211.10.15:5020/docker-compose.x86-64
# sudo mv docker-compose.x86-64 /usr/local/bin/docker-compose
# sudo chmod +x /usr/local/bin/docker-compose
# wget 10.211.10.15:5020/xdxct-container-runtime_1.0.0~rc.1-0_amd64.deb
# sudo dpkg -i xdxct-container-runtime_1.0.0~rc.1-0_amd64.deb
# wget 10.211.10.15:5020/some-images.txz
# tar -Jxf some-images.txz

# sudo echo "10.211.10.15  hub.xdxct.com" >> /etc/hosts
# sudo mkdir -p /etc/docker/certs.d/hub.xdxct.com
# sudo wget hub.xdxct.com:5020/xdxct.com.crt -O /etc/docker/certs.d/hub.xdxct.com/xdxct.com.crt

# echo "done"
# sudo newgrp docker

