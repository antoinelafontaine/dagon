#!/bin/bash

m.status() {
  printf "${1}\n"
}

m.error() {
  printf "     [x] - ${1}\n\n"
  exit 1
}

m.clearline() {
  printf "\r%${COLUMNS}s" ""
}


m.progress() {

  if [ ${1} == 'abort' ]; then
    printf " Aborted!\n"
    return 0
  fi

  let _progress=(${1}*100/${2}*100)/100
  let _done=(${_progress}*4)/10
  let _left=40-$_done

  _fill=$(printf "%${_done}s")
  _empty=$(printf "%${_left}s")
  _terminal_width=$(tput cols)
  _blank=$(printf "%${_terminal_width}s" " ")
  
  printf "\r${_blank// / }\rProgress : [${_fill// /#}${_empty// /-}] - $3"
  if [ ${_progress} == "100" ]; then
    printf "\n"
  fi
}

