#!/usr/bin/env bash

THIS_DIR=$(cd $(dirname $0); pwd)
cd $THIS_DIR

sudo apt-get update

sudo apt-get upgrade -y

