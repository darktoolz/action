#!/bin/bash

. lib.bash

echo "started action:\n   repo-parse $@"
test -n "$1" || die "require repository url"

#defined GITHUB_OUTPUT && test -s $GITHUB_OUTPUT && truncate -s0 $GITHUB_OUTPUT

url="$(tolower "$1")"

startswith "$url" 'http://' && scheme=http || scheme=https

echo "$url" | sed 's/^\w*\:\/\///' | sed 's/\//\t/' | sed -E 's/([\#\@])([^\#\@]*)$/\t\2\t\1/' | read domain repo tag delim
url="$scheme://$domain/$repo$delim$tag"

output scheme domain repo url tag
