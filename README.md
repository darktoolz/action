# common github actions
Actions accept git repositories located on both Gitlab and Github services.
Every action could fetch info using both APIs / links / protocols.

Repository actions:
- `repo-parse`: repo url to scheme+domain+repo+tag
- `repo-exists`: check repo existance
- `repo-info`: get repo info

Tag actions:
- `tag-exists`: check tag existance
- `tag-latest`: get latest tag
- `tag-push`: push tag
- `tag-info`: get tag info

Release actions:
- `release-exists`: check release existance
- `release-latest`: get latest release
- `release-push`: push release
- `release-info`: get release info

## specific actions
To add standard actions operating with `.msi`, `luarocks`, `.py` and other modules.

MSI actions:
- `msi-create`: create `.msi`

## lib.sh
Using few helper Bash libs to implement Github Actions (composite).
- `lib.sh` 
- `curl.sh`

## testing
Action test is located in `.github/workflows/test-*.yml` and runs on source updates.
