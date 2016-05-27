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
    if [ -e "/usr/local/dagon/flags/${1}" ]; then
      return 0
    fi
  fi
  return 1
}

flag.set() {
  flag._checkFlagFolderExists
  touch "/usr/local/dagon/flags/${1}"
}

flag.remove() {
  flag._checkFlagFolderExists
  if [ $1 == 'all' ]; then
    rm /usr/local/dagon/flags/*
  else
    rm "/usr/local/dagon/flags/${1}"
  fi
}

lastCommand.successful() {
  if [ $? == 0 ]; then
    return 0;
  else
    return 1;
  fi
}

lastCommand..failed() {
  if [ $? == 1 ]; then
    return 0;
  else
    return 1;
  fi
}

lastCommand.not.successful() {
  if [ $? != 0 ]; then
    return 0;
  else
    return 1;
  fi
}

lastCommand.not.failed() {
  if [ $? != 1 ]; then
    return 0;
  else
    return 1;
  fi
}

check.successful() {
  lastCommand.successful
}

check.failed() {
  lastCommand.failed
}

check.not.successful() {
  lastCommand.not.successful
}

check.not.failed() {
  lastCommand.not.failed
}
