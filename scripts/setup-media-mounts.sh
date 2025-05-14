#!/bin/bash

set -e
set -u


source "$(pwd)/.env"

sudo mkdir -p /media/{Books,Downloads,Movies,Music,Shows}
sudo chown -R "$USER:$USER" /media/{Books,Downloads,Movies,Music,Shows}

sudo apt install -u cifs-utils curl smbclient

touch ~/.smbcredentials
cat <<EOF > ~/.smbcredentials
username=${NETWORK_MOUNT_USERNAME}
password=${NETWORK_MOUNT_PASSWORD}
domain=${NETWORK_MOUNT_WORKGROUP}
EOF

USER=$(whoami)

sudo echo "//${NETWORK_MOUNT_HOST}/Shows ${TV_DIR} cifs credentials=/home/${USER}/.smbcredentials,iocharset=utf8,rw,uid=1000,gid=1000 0 0
//${NETWORK_MOUNT_HOST}/Music ${MUSIC_DIR} cifs credentials=/home/${USER}/.smbcredentials,iocharset=utf8,rw,uid=1000,gid=1000 0 0
//${NETWORK_MOUNT_HOST}/Movies ${MOVIE_DIR} cifs credentials=/home/${USER}/.smbcredentials,iocharset=utf8,rw,uid=1000,gid=1000 0 0
//${NETWORK_MOUNT_HOST}/Downloads ${DOWNLOAD_DIR} cifs credentials=/home/${USER}/.smbcredentials,iocharset=utf8,rw,uid=1000,gid=1000 0 0
//${NETWORK_MOUNT_HOST}/Books ${BOOKS_DIR} cifs credentials=/home/${USER}/.smbcredentials,iocharset=utf8,rw,uid=1000,gid=1000 0 0" | sudo tee -a /etc/fstab
sudo mount -a