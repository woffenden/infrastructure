#!/usr/bin/env bash

docker build \
  --file .devcontainer/features/test/Containerfile \
  --tag devcontainer-test \
  .

docker run -it --rm \
  --volume "${PWD}":/workspace \
  --volume "${PWD}"/.devcontainer/features/src/base/src/usr/local/bin/devcontainer-utils:/usr/local/bin/devcontainer-utils \
  devcontainer-test
