#!/bin/sh

# run: ./run.sh "${{ inputs.url }}"
# run: ${{github.action_path}}/action.sh "${{ inputs.url }}"

test -d "${GITHUB_ACTION_PATH}" || die "no actions dir in:\n$(ls ${GITHUB_ACTION_PATH})"
test -f "${GITHUB_ACTION_PATH}/action.sh" || die "no action file in ${GITHUB_ACTION_PATH}:\n$(ls ${GITHUB_ACTION_PATH})"
exec "${GITHUB_ACTION_PATH}/action.sh" "$@"
