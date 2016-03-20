#!/bin/bash

flag._checkFlagFolderExists() {
  cd /usr/local/dagon 2>&-
  if [ $? == 1 ]; then
    return 1
  fi
  if [ -d ./flags/ ]; then
    return 0
  fi
  return 1
}
flag.check() {
  flag._checkFlagFolderExists
  if [ $? != 1 ]; then
    if [ -e "./flags/${1}" ]; then
      return 0
    fi
  fi
  return 1
}

flag.set() {
  flag._checkFlagFolderExists 
  touch "./flags/${1}"
}

sudo.keepalive() {
  sudo -v
  while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>&-
}

