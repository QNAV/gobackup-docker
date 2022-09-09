#!/bin/bash

docker run --rm -v /Users/weibocy/gobackup-docker/:/Users/weibocy/gobackup-docker/ -v /Users/weibocy/gobackup-docker/demo/gobackup.yml:/root/.gobackup/gobackup.yml --name gobackup-docker gobackup