#!/bin/bash
GIT_REPO="https://raw.githubusercontent.com/dircmd/dircmd/master"
curl --output /etc/profile.d/dircmd.sh ${GIT_REPO}/src/bash
