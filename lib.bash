#!/bin/bash

set -e
shopt -s lastpipe

#nonzero() { [ ! -z "$@" ] ;}
not() { [ $# -gt 0 ] && for i in "$@"; do [ ! -z "$i" ] && return 1; done; return 0 ;}
notany() { [ $# -gt 0 ] && for i in "$@"; do [ -z "${!i}" ] && return 0; done; return 1 ;}
success() { return $? ;}

say() { echo -n "$@" ;}
err() { echo 1>&2 "$@" ;}
die() { echo "$@" 1>&2; exit 255 ;}
printvar() { test -z "$1" || echo "$1=${!1}" ;}

map() { local a="$1"; shift; while test $# -gt 0; do test -z "$1" || $a "$1"; shift; done ;}

dump() { map printvar "$@" ;}
errdump() { dump "$@" 1>&2 ;}

tolower() { echo -n "$@" | tr '[:upper:]' '[:lower:]'; return 0 ;}
toupper() { echo -n "$@" | tr '[:lower:]' '[:upper:]'; return 0 ;}

startswith() { case "$1" in "$2"*) true;; *) false;; esac; }
endswith()   { case "$1" in *"$2") true;; *) false;; esac; }

defined() { [[ -v "$1" ]] ;}
undefined() { [[ ! -v "$1" ]] ;}
output() { defined GITHUB_OUTPUT && dump "$@" >> $GITHUB_OUTPUT || dump "$@" ;}

join(){ local IFS="$1"; shift; echo "$*"; }

#joinn() { for i; do echo "$i"; done ; return 0;}
#uniqs() { sort|uniq|tr "\r\n" ' '|xargs echo -n ;}

run() {
  local action="$1"
  shift
  test -d .github/actions || die "no actions dir in .:\n$(ls .)"
  test -d ".github/actions/$action" || die "no actions dir in:\n$(ls .github/actions)"
  test -f ".github/actions/$action/action.sh" || die "no action file in .github/actions/$action:\n$(ls .github/actions/$action)"
  source ".github/actions/$action/action.sh"
  return $?
}
#run "$@"
