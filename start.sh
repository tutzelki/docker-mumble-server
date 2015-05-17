#!/bin/bash

UID_old=$(cat /etc/passwd | grep mumble-server | cut -d: -f3)
GID_old=$(cat /etc/passwd | grep mumble-server | cut -d: -f4)

echo "Checking if UID and GID have to be changed"


if [ -z "$UIDd" ]
then
  UIDd=501
fi
if [ -z "$GIDd" ]
then
  GIDd=501
fi

echo Setting mumble-server:mumble-server to "$UIDd" : "$GIDd"

if [ "$UIDd" -ge 1 -a "$UIDd" -le 65534 ]
then
  if [ "$UIDd" -ne "$UID_old" ]
  then
    $(usermod -u $UIDd mumble-server)
    echo UID changed.
  fi
fi

if [ "$GIDd" -ge 1 -a "$GIDd" -le 65534 ]
then
  if [ "$GIDd" -ne "$GID_old" ]
  then
    $(groupmod -g $GIDd mumble-server)
    echo GID changed.
  fi
fi

echo Checking if /data/mumble-server.ini exists.
if [ ! -f /data/mumble-server.ini ]
then
  sed -i 's/var.log.mumble-server/data/' /etc/mumble-server.ini
  sed -i 's/var.lib.mumble-server/data/' /etc/mumble-server.ini
  cp /etc/mumble-server.ini /data
  chmod a+rw /data/mumble-server.ini
  echo Created /data/mumble-server.ini. Exiting.
  exit 1
fi

MURVERS=$(murmurd -version)
echo Starting mumble-server
sudo -u mumble-server -g mumble-server murmurd -fg -ini /data/mumble-server.ini
exit 0
