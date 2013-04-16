#!/bin/bash

HERE=`dirname $0`
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # Load RVM function
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

cd $HERE

.bin/shotgun rikiki.rb

