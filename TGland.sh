#!/bin/bash

# Author: Neil "regalstreak" Agarwal <regalstreak@gmail.com>

# Check if user has screen, if not install it
if [ !$( which screen ) ]; then
  echo "Update Server Ubuntu please wait"
  sudo apt-get update
  sudo apt-get upgrade -y
  sudo apt-get install libreadline-dev libconfig-dev libssl-dev lua5.2 liblua5.2-dev libevent-dev make unzip git redis-server g++ libjansson-dev libpython-dev expat libexpat1-dev -y
  chmod +x launch.sh
  ./launch.sh install
  ./launch.sh
fi

#Channel: @TGland
#IT Channel: @ITTGland
