GIT_REPO="https://github.com/dircmd/dircmd/raw/master"
sudo curl --location --silent --output /etc/profile.d/dircmd.sh ${GIT_REPO}/src/bash
mkdir ~/.dircmd
curl --location --silent --output ~/.dircmd/entry ${GIT_REPO}/examples/helloworld/entry
curl --location --silent --output ~/.dircmd/exit ${GIT_REPO}/examples/helloworld/exit
