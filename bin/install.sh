#!/bin/bash
GIT_REPO="https://raw.githubusercontent.com/dircmd/dircmd/master"
curl --location --silent --output /etc/profile.d/dircmd.sh ${GIT_REPO}/src/bash
