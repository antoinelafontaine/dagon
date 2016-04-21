#!/bin/bash

requirements.set() {
  requirements="$1"
}

requirements.failure() {
  newVariable="failureActions__$1=\"$2\""
  eval "${newVariable}"
}

requirements.check() {
  local count="$(wc -w <<< $requirements)"
  local index=0

  for requirement in $requirements; do
    hash "$requirement" 2>&-

    if [ $? == 1 ]; then
      failureAction="failureActions__$requirement"
      if [ "${!failureAction}" == abort ]; then
      	m.progress abort
      	m.error "Missing requirement: ${requirement}"
      fi

      m.progress $index $count "${requirement} not found - installing"
      ${!failureAction} 2>&-
    fi

    index=$((index + 1))
    m.progress $index $count "${requirement} ☑️   "

    sleep 0.1
  done;
}
