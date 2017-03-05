#!/usr/bin/env bash
if [ -f cache/vars ]; then
  . cache/vars
fi
if [ -z ${!1} ]; then
  read -p "Enter your $2: " $1
  test -z ${!1} && exit
  test ! -d cache && mkdir cache
  echo "$1=${!1}" >> cache/vars
fi
