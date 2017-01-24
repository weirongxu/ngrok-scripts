#!/usr/bin/env bash
test -z ${!1} && read -p "Enter your $2: " $1
test -z ${!1} && exit
