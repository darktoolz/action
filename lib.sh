#!/bin/bash

shopt -s lastpipe

die()         { echo "ERROR:" "$@" 1>&2; exit 255 ;}
say()         { echo -n "$@" ;}
err()         { echo 1>&2 "$@" ;}
printvar()    { test -z "$1" || echo "$1=${!1}" ;}

map()         { local a="$1"; shift; while test $# -gt 0; do test -z "$1" || $a "$1"; shift; done ;}
iif()         { test "$1" = "0" && echo "$2" && return 0 || echo "$3"; return 1 ;}

dump()        { map printvar "$@" ;}
errdump()     { dump "$@" 1>&2 ;}

not()         { [ $# -gt 0 ] && for i in "$@"; do [ ! -z "$i" ] && return 1; done; return 0 ;}
notany()      { [ $# -gt 0 ] && for i in "$@"; do [ -z "${!i}" ] && return 0; done; return 1 ;}
success()     { return $? ;}

tolower()     { echo -n "$@" | tr '[:upper:]' '[:lower:]'; return 0 ;}
toupper()     { echo -n "$@" | tr '[:lower:]' '[:upper:]'; return 0 ;}

startswith()  { case "$1" in "$2"*) true;; *) false;; esac; }
endswith()    { case "$1" in *"$2") true;; *) false;; esac; }

defined()     { [[ -v "$1" ]] ;}
undefined()   { [[ ! -v "$1" ]] ;}

join()        { local IFS="$1"; shift; echo "$*"; }

xtest()       { test "`cat`" "$@" ;}
ytest()       { test "$@" "`cat`" ;}
digits()      { say "$1" | grep -sE '^\s*[0-9]+\s*$' ;}
isdigits()    { digits "$@" | ytest '' != ;}
coalesce()    { while test $# -gt 0; do test -n "$1" -o ${#1} -gt 0 && say "$1" && return 0; shift; done ;}
