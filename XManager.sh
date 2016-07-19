#!/bin/bash

# Author: Neil "regalstreak" Agarwal <regalstreak@gmail.com>

# Check if user has screen, if not install it
if [ !$( which screen ) ]; then
  echo "Installing screen for running XManager in background"
  sudo apt install screen
fi

# Run XManager in a screen
screen -A -m -d -S XManager sh launch.sh