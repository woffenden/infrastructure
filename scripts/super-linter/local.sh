#!/usr/bin/env bash

MODE="${1:-local}"

case "${MODE}" in
local)
  echo "Running Super-Linter in RUN_LOCAL mode"
  docker run --rm \
    --env RUN_LOCAL="true" \
    --env CREATE_LOG_FILE="true" \
    --env LOG_FILE_NAME="/tmp/log/super-linter.log" \
    --env-file ".github/super-linter.env" \
    --volume "${PWD}":/tmp/log \
    --volume "${PWD}":/tmp/lint \
    ghcr.io/super-linter/super-linter:slim-v5
  ;;
interactive)
  echo "Running Super-Linter in INTERACTIVE mode"
  docker run --rm -it \
    --entrypoint /bin/bash \
    --volume "${PWD}":/tmp/lint \
    --workdir /tmp/lint \
    ghcr.io/super-linter/super-linter:slim-v5
  ;;
*)
  echo "Invalid mode: ${MODE}"
  echo "Usage: ${0} [local|interactive]"
  exit 1
  ;;
esac
