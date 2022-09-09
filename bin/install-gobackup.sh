#!/bin/bash
get_latest_release() {
	curl --silent "https://api.github.com/repos/$repo/releases/latest" | # Get latest release from GitHub api
		grep '"tag_name":' |                                            # Get tag line
		sed -E 's/.*"([^"]+)".*/\1/'                                    # Pluck JSON value
	}

repo='huacnlee/gobackup'
version=`get_latest_release`
if [[ `uname` == 'Darwin' ]]; then
   platform='darwin'
else
   platform='linux'
fi
if [[ `arch` == 'arm64' ]]; then
	arch='arm64'
else
	arch='amd64'
fi
curl -SLo gobackup.tar.gz https://github.com/huacnlee/gobackup/releases/download/$version/gobackup-$platform-$arch.tar.gz
tar zxf gobackup.tar.gz

if [[ `whoami` == 'root' ]]; then
   mv gobackup /usr/local/bin/gobackup
else
   sudo mv gobackup /usr/local/bin/gobackup
fi
mkdir -p ~/.gobackup && touch ~/.gobackup/gobackup.yml
rm gobackup.tar.gz
