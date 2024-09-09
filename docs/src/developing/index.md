# Developing

## Dev Container

This project [provides](https://github.com/woffenden/infrastructure/blob/main/.devcontainer/devcontainer.json) a [dev container](https://containers.dev/overview), which can be launched as a GitHub Codespace using the button below ⬇️

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/woffenden/infrastructure)

This _should_ also work running locally, but isn't tested regularly so your milage may vary 🐉

## Signed Commits

This project requires [signed commits](https://docs.github.com/en/authentication/managing-commit-signature-verification/signing-commits)

You can enable this in GitHub Codespaces by following [GitHub's guidance](https://docs.github.com/en/codespaces/managing-your-codespaces/managing-gpg-verification-for-github-codespaces#enabling-or-disabling-gpg-verification)

You can also enable this locally by following GitHub's guidance for [GPG](https://docs.github.com/en/authentication/managing-commit-signature-verification/about-commit-signature-verification#gpg-commit-signature-verification) or [SSH](https://docs.github.com/en/authentication/managing-commit-signature-verification/about-commit-signature-verification#ssh-commit-signature-verification) commit signature verification

## Super-Linter

[![Super-Linter](https://github.com/woffenden/infrastructure/actions/workflows/super-linter.yml/badge.svg)](https://github.com/marketplace/actions/super-linter)

This project has Super-Linter [configured](https://github.com/woffenden/infrastructure/blob/main/.github/workflows/super-linter.yml) to run on pull requests to `main` branch

The dev container aims to provide automatic linting where possible, but if you need to run Super-Linter locally, you can run the following

1. `run-local` mode, which runs Super-Linter similar to how GitHub Actions does, but makes some changes to run locally as per [their guidance](https://github.com/super-linter/super-linter/blob/main/docs/run-linter-locally.md#run-super-linter-locally)

    ```bash
    bash scripts/super-linter/local.sh
    ```

1. `interactive` mode, which drops you into a bash shell in the Super-Linter container to run any of the binaries you require against the offending file(s)

## External Service Authentication

### Amazon Web Services

The dev container includes [synfinatic/aws-sso-cli](https://github.com/synfinatic/aws-sso-cli)

You can list available profiles with the following command, and follow the provided URL to authenticate with AWS Identity Centre

```bash
aws-sso list
```

You can then assume a profile with the following command

```bash
aws-sso --profile ${PROFILE_NAME}
```

For example

```bash
aws-sso --profile root:cloud-platform-administrator
```

### Google Cloud Platform

The dev container includes [Google Cloud's CLI](https://cloud.google.com/sdk/gcloud)

You can log in to Google Cloud Platform by running the following command

```bash
gcloud auth login
```

#### Application Default Credentials

If you need Application Default Credentials for SDKs or Terraform, run the following command

```bash
gcloud auth application-default login
```

### Tailscale

The dev container includes [`ghcr.io/tailscale/codespace/tailscale`](https://github.com/tailscale/codespace) for connecting to resources that aren't exposed to the public internet but are exposed to the `woffenden.io` Tailscale organisation

To connect to the tailnet, run the following command, and follow the provided URL to authenticate with Tailscale using your Google Workspace account

    ```bash
    sudo tailscale up
    ```
