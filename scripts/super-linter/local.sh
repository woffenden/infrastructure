#!/usr/bin/env bash

docker run --rm \
  --env RUN_LOCAL="true" \
  --env-file ".github/super-linter.env" \
  --volume "${PWD}":/tmp/lint \
  ghcr.io/super-linter/super-linter:slim-v5
