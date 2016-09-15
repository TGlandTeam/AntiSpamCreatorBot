#!/usr/bin/env bash

THIS_DIR=$(cd $(dirname $0); pwd)
cd $THIS_DIR

chmod +x tgland2.sh

sudo apt-get update

sudo apt-get upgrade -y

