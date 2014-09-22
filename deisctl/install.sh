#!/bin/sh

# try to detect Linux distribution family
OS=`hostnamectl status 2> /dev/null | sed -n -e 's/^.*Operating\ System: //p' | cut -d " " -f1`
if [ "$OS" = "CoreOS" ]; then
    mkdir -p /opt/bin
    INSTALLER_OPTS="--target /opt/bin"
fi

# catch errors from here on out
set -e

# determine from whence to download the installer
PLATFORM=`uname | tr '[:upper:]' '[:lower:]'`
DEIS_INSTALLER=${DEIS_INSTALLER:-deisctl-0.12.0-dev-$PLATFORM-amd64.run}
DEIS_BASE_URL=${DEIS_BASE_URL:-https://s3-us-west-2.amazonaws.com/opdemand}
INSTALLER_URL=$DEIS_BASE_URL/$DEIS_INSTALLER

# download the installer archive to /tmp
curl -f -o /tmp/$DEIS_INSTALLER $INSTALLER_URL

# run the installer
sh /tmp/$DEIS_INSTALLER $INSTALLER_OPTS

# clean up after ourselves
rm -f /tmp/$DEIS_INSTALLER
