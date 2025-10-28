#!/bin/bash

. lib.bash

#echo "started action:"
#echo "   repo-parse $@"
#test -n "$1" || die "require repository url"

url="$(tolower "$1")"
startswith "$url" 'http://' && scheme=http || scheme=https

if test -z "$url" -o "$url" = "${GITHUB_REPOSITORY}" -o "$url" = "$(tolower "${GITHUB_REPOSITORY}")"; then
  domain=github.com
  repo=${GITHUB_REPOSITORY}
fi

c="$(echo -n "$url" | grep -o '\/' | tr -d "\n" | wc -c)"

if test "$c" = "1"; then
  if echo -n "$url" | grep -s '\.'; then
    die "invalid argument format: $1"
#  else
# if echo -n "$url" | grep -o '^([^\.]*)\/'; then
  fi
  domain=github.com
  repo="$url"
else
  echo "$url" | sed 's/^\w*\:\/\///' | sed 's/\//\t/' | sed -E 's/([\#\@])([^\#\@]*)$/\t\2\t\1/' | read domain repo tag delim
fi

url="$scheme://$domain/$repo$delim$tag"

output scheme domain repo url tag
