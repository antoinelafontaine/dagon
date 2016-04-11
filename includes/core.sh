#!/bin/bash

flag._checkFlagFolderExists() {
  cd /usr/local/dagon 2>&-
  if [ $? == 1 ]; then
    return 1
  fi
  if [ -d ./.dagon/flags/ ]; then
    return 0
  fi
  return 1
}
flag.check() {
  flag._checkFlagFolderExists
  if [ $? != 1 ]; then
    if [ -e "/usr/local/dagon/.dagon/flags/${1}" ]; then
      return 0
    fi
  fi
  return 1
}

flag.set() {
  flag._checkFlagFolderExists
  touch "/usr/local/dagon/.dagon/flags/${1}"
}

flag.remove() {
  flag._checkFlagFolderExists
  rm "/usr/local/dagon/.dagon/flags/${1}"
}
