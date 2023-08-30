#!/usr/bin/env bash

docker run --rm \
  --env RUN_LOCAL="true" \
  --env CREATE_LOG_FILE="true" \
  --env LOG_FILE_NAME="/tmp/log/super-linter.log" \
  --env-file ".github/super-linter.env" \
  --volume "${PWD}":/tmp/log \
  --volume "${PWD}":/tmp/lint \
  ghcr.io/super-linter/super-linter:slim-v5
