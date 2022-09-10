#!/bin/bash

docker run --rm -v /Users/weibocy/gobackup-docker/:/Users/weibocy/gobackup-docker/ -v /Users/weibocy/gobackup-docker/demo/test.yml:/root/.gobackup/gobackup.yml -v test_tmp:/tmp --name gobackup-docker gobackup