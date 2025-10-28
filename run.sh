#!/bin/sh

run() {
  local action="$1"
  shift
#  test -d .github/actions || die "no actions dir in .:\n$(ls .)"
#  test -d ".github/actions/$action" || die "no actions dir in:\n$(ls .github/actions)"
  test -d "${GITHUB_ACTION_PATH}" || die "no actions dir in:\n$(ls ${GITHUB_ACTION_PATH})"
#  test -f ".github/actions/$action/action.sh" || die "no action file in .github/actions/$action:\n$(ls .github/actions/$action)"
#  source ".github/actions/$action/action.sh"
  source "${GITHUB_ACTION_PATH}/action.sh"
  return $?
}

run "$@"
