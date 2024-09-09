#!/usr/bin/env bash

superLinterVersion="$(grep 'super-linter/super-linter/slim' .github/workflows/super-linter.yml | awk -F'#' '{print $2}' | awk '{print $1}')"
export superLinterVersion
echo "Super-Linter version: ${superLinterVersion}"

MODE="${1:-run-local}"

case "${MODE}" in
run-local)
  sudo rm -rf super-linter.log

  echo "Running Super-Linter in RUN_LOCAL mode"
  docker run --rm \
    --env RUN_LOCAL="true" \
    --env CREATE_LOG_FILE="true" \
    --env LOG_LEVEL="DEBUG" \
    --env LOG_FILE_NAME="super-linter.log" \
    --env SUPER_LINTER_OUTPUT_DIRECTORY_NAME="/tmp/log" \
    --env-file ".github/super-linter.env" \
    --volume "${PWD}":/tmp/log \
    --volume "${PWD}":/tmp/lint \
    "ghcr.io/super-linter/super-linter:slim-${superLinterVersion}"

  sudo chown "$(id --user):$(id --group)" super-linter.log
  ;;
interactive)
  echo "Running Super-Linter in interactive mode"
  docker run --rm -it \
    --entrypoint /bin/bash \
    --env-file ".github/super-linter.env" \
    --volume "${PWD}":/tmp/lint \
    --workdir /tmp/lint \
    "ghcr.io/super-linter/super-linter:slim-${superLinterVersion}"
  ;;
*)
  echo "Invalid mode: ${MODE}"
  echo "Usage: ${0} [run-local|interactive]"
  exit 1
  ;;
esac
