#!/bin/bash
GIT_REPO="https://github.com/dircmd/dircmd/raw/master"
curl --location --silent --output /etc/profile.d/dircmd.sh ${GIT_REPO}/src/bash
sleep 2s && source /etc/profile.d/dircmd.sh &
