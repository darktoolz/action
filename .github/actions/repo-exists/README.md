# repo-exists github action
Checks for repository existence without authorization.

Accepted parameters specified in `repo-parse` action (excluding `tag` field which is nonsense).
- `url`: repository URL in full or short form (`github.com/darktoolz/action` is OK)
- `repo`: repo name (owner/name)
- `domain`: `github.com`, `gitlab.com` or maybe standalone Gitlab server
- `scheme`: `http` or `https` (`git`/`ssh` are not supported)

HTTP HEAD query returning `200 OK` is expected.

Result is written to `exists` output variable (`steps.check.outputs.exists`).
