# repo-parse github action
Input, parse and normalize git repository address.

Accepted parameters:
- `url`: repository URL in full or short form (`github.com/darktoolz/action` is OK)
- `repo`: repo name (owner/name)
- `domain`: `github.com`, `gitlab.com` or maybe standalone Gitlab server
- `scheme`: `http` or `https` (`git`/`ssh` are not supported)
- `tag`: valid tag: `@v1`, `#v18.0.1` both accepted

Incompatible arguments (ex. full URL but repo name with different owner) are not accepted.
Incomplete arguments are completed if possible.
It is possible to specify URL input without tag but fill `tag` input field.
Empty inputs result in the use of current repository.

Resulting outputs use same names. All fields are filled.
No check for repo name length is done: `a/very/log/repo/name` is ok because Gitlab has multi-level subgroups.
There is also no check for any subdir length. `a/b/c/d/e` is OK because some private services use short forms for group names.

This actions mostly used by other actions in this repo.

Arguments specified in ENV vars are also accepted. This could be useful for permanent configs.

### example usage in workflow
```yml
runs:
  using: composite
  steps:
    - name: Parse input arguments
      id: repo
      uses: ./.github/actions/repo-parse
      with:
        url: ${{ inputs.url }}
        repo: ${{ inputs.repo }}
        domain: ${{ inputs.domain }}
        scheme: ${{ inputs.scheme }}
```
