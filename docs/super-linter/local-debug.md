# Super-Linter Local Debug

There are two options:

1. Run Super-Linter in `RUN_LOCAL` mode

    ```bash
    bash scripts/super-linter/local/main.sh
    ```

2. Launch Super-Linter as an interactive container

    ```bash
    docker run -it --rm \
      --entrypoint /bin/bash \
      --volume $(pwd):/tmp/lint \
      --workdir /tmp/lint \
      ghcr.io/github/super-linter:v5.0.0
    ```
