#!/usr/bin/env bash
if [ -f cache ]; then
  . cache
fi
if [ -z ${!1} ]; then
  read -p "Enter your $2: " $1
  test -z ${!1} && exit
  echo "$1=${!1}" >> cache
fi
