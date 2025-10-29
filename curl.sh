#!/bin/bash

export curl_options="--compressed -sL"

# url / scheme normalization
has_scheme()  { test -n "$1" && say "$1" | grep -qE '(^\w+\:\/\/)' || return $? ;}  # has_scheme <$url>         => &&
get_scheme()  { printf '%s://' "$(coalesce "${1:-}" https)" ;}                      # get_scheme  <http>        => http://
scheme()      { has_scheme "$1" || test -z "$1" || get_scheme "$2" ;}               # scheme  $domain <http>    => http:// || ""
site()        { printf '%s%s' `scheme $1 $2` "$1" ;}                                # site    $domain <http>    => https://domain.com

# generate both github/gitlab auth headers using single function
curl_header() { test -z "$1" -o -z "$2" && say "" || say "-H '$1: $2'" ;}           # curl_header Authorization "Bearer TOKEN"

# curl_head $url
curl_head_http_code()   {
  local url="$1"
  local i="$2"

  curl $curl_options -o /dev/null -siI -w "%{http_code}" "$url"
}

curl_head()   {
  local url="$1"
  local i="$2"

  $curl -iI -w "%{http_code}" "$url"
}
