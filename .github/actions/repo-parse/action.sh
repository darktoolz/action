#!/bin/bash

set -e
. lib.sh

# everything normalized
url="`tolower "$1"`"
REPO="$(tolower "$REPO")"
DOMAIN="$(tolower "$DOMAIN")"
TAG="$(tolower "$TAG")"
SCHEME="$(tolower "$SCHEME")"

GITHUB_REPOSITORY="$(tolower "$GITHUB_REPOSITORY")"

# http/https only; ssh/git is not supported right now
if startswith "$url" 'http://' || test "$SCHEME" = http; then
  startswith "$url" 'https://' && die "scheme argument conflict"
  scheme=http
else
  scheme=https
fi

# conflict check
if test -z "$url" -o "$url" = "${GITHUB_REPOSITORY}"; then
  # domain env arg acceptable in any case
  test -n "$DOMAIN" && domain="$DOMAIN" || domain=github.com

  # checking conflict: nonzero REPO other than url==GITHUB_REPOSITORY
  test -z "$REPO" -o -z "$url" -o "$REPO" = "$url" || die "repo argument conflict: '$url' != '$REPO'"
  test -n "$REPO" && repo="$REPO" || repo=${GITHUB_REPOSITORY}
else
  # url contains repo or some invalid record, lets fast check
  c="$(echo -n "$url" | grep -o '\/' | tr -d "\n" | wc -c)"
  # owner/name    == valid
  # host.com/name == invalid
  if test "$c" = "1"; then
    if echo -n "$url" | grep -s '\.'; then
      # host/ip: git username does not contain dots
      die "invalid argument format: $url"
    fi

    # check for same conflict but url is not empty
    test -z "$REPO" -o "$REPO" = "$url" || die "repo argument conflict: '$url' != '$REPO'"

    test -n "$REPO" && repo="$REPO" || repo="$url"
    test -n "$DOMAIN" && domain="$DOMAIN" || domain=github.com
  else
    # have full url here
    echo "$url" | sed 's/^\w*\:\/\///' | sed 's/\//\t/' | sed -E 's/([\#\@])([^\#\@]*)$/\t\2\t\1/' | read domain repo tag delim

    # check for conflicts with different DOMAIN, REPO, TAG
    test "$domain" = "$DOMAIN" -o -z "$DOMAIN" || die "domain argument conflict: '$domain' != '$DOMAIN'"
    test "$repo" = "$REPO" -o -z "$REPO" || die "repo argument conflict: '$repo' != '$REPO'"
    test "$tag" = "$TAG" -o -z "$tag" -o -z "$TAG" || die "tag argument conflict: '$tag' != '$TAG'"
  fi
fi

# repo should always be provided
test -n "$repo" || die "invalid argument: empty repository"

# could be optional argument + url
test -n "$tag" || tag="$TAG"
test -z "$tag" -o -n "$delim" || delim='#'

url="$scheme://$domain/$repo$delim$tag"

dump scheme domain repo url tag