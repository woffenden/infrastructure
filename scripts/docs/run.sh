#!/usr/bin/env bash

set -e

docker run -it --rm \
    --volume "${PWD}"/docs:/docs \
    --volume "${PWD}"/scripts:/scripts \
    --workdir /docs \
    --publish 8000:8000 \
    --entrypoint /bin/bash \
    public.ecr.aws/docker/library/python:3.10-slim \
    /scripts/docs/preview.sh
