#!/bin/bash

## erase or take back clipped date after <INTERVAL> seconds, if it is enabled.
ERACE=True

## timing parameter for <ERASE>
INTERVAL=5

## take back to previous clipped date after <INTERVAL> seconds, if it is enabled and <ERACE> is enabled.
REDO=True

## add new line at end of lastpass data, if it is enabled.
  #NEW_LINE=True

## login account
MY_ID=your_account@your_domain

### end of config



MY_CMD=$(basename ${0})
case ${MY_CMD} in
  lpw) TYPE=password ;;
  lun) TYPE=username ;;
  lst) lpass status         ; exit 0 ;;
  lli) lpass login ${MY_ID} ; exit 0 ;;
  llo) lpass logout         ; exit 0 ;;
  lls) lpass ls ${1}        ; exit 0 ;;
  *)   lpass status         ; exit 0 ;;
esac

function ECHO_STDERR() {
  echo "${1}" >&2
}

if [ 0 -ne $(which lpass >/dev/null ; echo ${?}) ]; then
  MSG=$(cat <<EOF
  Error: lpass command not found. You should execute following command.
brew install lastpass-cli
EOF
  )

  ECHO_STDERR "${MSG}"
  exit 99
fi

if [ 1 -gt ${#} -o 2 -lt ${#} ]; then
  MSG=$(cat <<EOF
  Usage: ${0} [-a] <LastPassEntryName>
         Option -a is  On: Output into stdout.
                      Off: Copy into Clipboard.
EOF
  )

  ECHO_STDERR "${MSG}"
  exit 19
fi

OPT=${@}
if [ 0 -eq $(echo ${@} | grep -e '^-a ' -e ' -a$' >/dev/null ; echo ${?}) ]; then
  OPT_A=True
  OPT=$(echo ${@} | sed -e 's/\-a//')
fi

if [ ${OPT_A} ]; then
  lpass show --${TYPE} ${OPT}
else
  NL_OPT='-n'
  if [ ${REDO} ]; then
    BACKUP="$(pbpaste)"
    NL_OPT=''
  fi

  if [ ${NEW_LINE} ]; then
    lpass show --${TYPE} ${OPT} | pbcopy
  else
    lpass show --clip --${TYPE} ${OPT}
  fi
  ECHO_STDERR '  Info: Copyied to clipboard.'

  if [ ${ERACE} ]; then
    (sleep ${INTERVAL} ; echo ${NL_OPT} "${BACKUP:-}" | pbcopy) &
  fi
fi

