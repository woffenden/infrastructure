#!/usr/bin/env bash

FEATURE_TO_TEST="${1}"

docker build \
  --file .devcontainer/features/test/Containerfile \
  --tag devcontainer-test \
  .

devcontainer \
  features \
  test \
  --project-folder .devcontainer/features \
  --features "${FEATURE_TO_TEST}" \
  --skip-scenarios \
  --base-image devcontainer-test
