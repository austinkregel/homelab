#!/bin/bash

set -e
set -u

sudo mkdir -p /media/{Books,Downloads,Movies,Music,Shows}
sudo chown -R "$USER:$USER" /media/{Books,Downloads,Movies,Music,Shows}

sudo apt install -u cifs-utils curl smbclient

sudo cat <<EOF >> /etc/fstab
//192.168.1.211/Shows /media/Shows cifs credentials=/home/austinkregel/.smbcredentials,iocharset=utf8,rw,uid=1000,gid=1000 0 0
//192.168.1.211/Music /media/Music cifs credentials=/home/austinkregel/.smbcredentials,iocharset=utf8,rw,uid=1000,gid=1000 0 0
//192.168.1.211/Movies /media/Movies cifs credentials=/home/austinkregel/.smbcredentials,iocharset=utf8,rw,uid=1000,gid=1000 0 0
//192.168.1.211/Downloads /media/Downloads cifs credentials=/home/austinkregel/.smbcredentials,iocharset=utf8,rw,uid=1000,gid=1000 0 0
//192.168.1.211/Books /media/Books cifs credentials=/home/austinkregel/.smbcredentials,iocharset=utf8,rw,uid=1000,gid=1000 0 0
EOF
sudo mount -a