#!/usr/bin/env bash

THIS_DIR=$(cd $(dirname $0); pwd)
cd $THIS_DIR

chmod +x launch.sh

./launch.sh install

./launch.sh
