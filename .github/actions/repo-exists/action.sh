#!/bin/bash

. lib.sh
. curl.sh

repo="$(tolower "$1")"
domain="$(tolower "$2")"
scheme="$(tolower "$3")"

test -n "$repo"   || die "empty argument: repo"
test -n "$scheme" || scheme=https
test -n "$domain" || domain=github.com

url="$(site "$domain" "$scheme")/$repo"
code="$(curl_head_http_code "$url")"
exists="$(test "$code" eq 200 && echo true || echo false)"

dump exists
