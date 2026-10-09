# API Pilot for Homebrew

Homebrew formula for `apipilot`, the command line tool from [API Pilot](https://github.com/thefolahan/api-pilot). It validates an OpenAPI spec, runs the saved requests in a workspace, serves a mock server and exports HTML docs.

```sh
brew install thefolahan/apipilot/apipilot
```

It builds from source, so it needs macOS 14 or later and the Xcode command line tools.

## Releasing a new version

Tag the release in `thefolahan/api-pilot`. The autobump workflow checks daily and opens a pull request here with the new URL and checksum. To do it by hand:

```sh
brew bump-formula-pr --url https://github.com/thefolahan/api-pilot/archive/refs/tags/vX.Y.Z.tar.gz thefolahan/apipilot/apipilot
```
