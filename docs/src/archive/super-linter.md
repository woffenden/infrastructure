# Super-Linter Local Debugging

There are two options:

## `RUN_LOCAL` (Default)

This mdoe runs Super-Linter against the entire codebase, it might take a while!

See <https://github.com/super-linter/super-linter/blob/main/docs/run-linter-locally.md>

``` bash
bash scripts/super-linter/local.sh
```

## `INTERACTIVE`

This mode launches an interactive terminal inside the Super-Linter container, allowing you to
execute a linter individually

``` bash
bash scripts/super-linter/local.sh interactive
```
