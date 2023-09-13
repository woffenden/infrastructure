#!/usr/bin/env bash

set -e

python3 -m pip install --no-cache-dir --requirement requirements.txt

mkdocs serve --dev-addr 0.0.0.0:8000
