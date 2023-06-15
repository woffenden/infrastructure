#!/usr/bin/env bash
# shellcheck disable=SC2129

export DEPENDABOT_CONFIGURATION_FILE=".github/dependabot.yml"

terraform=$(find . -type f -name ".terraform.lock.hcl" -exec dirname {} \; | sort -h | uniq | cut -c 3-)
export terraform

cat >"${DEPENDABOT_CONFIGURATION_FILE}" <<EOL
---
# This file is auto-generated, do not edit manually.
# scripts/dependabot/configuration-generator.sh

version: 2

updates:
  - package-ecosystem: "github-actions"
    directory: "/"
    schedule:
      interval: "daily"
      time: "09:00"
      timezone: "Europe/London"
    commit-message:
      prefix: "github-actions"
      include: "scope"
    reviewers:
      - "jacobwoffenden"
EOL

for folder in ${terraform}; do
  printf "  - package-ecosystem: \"terraform\"\n" >>"${DEPENDABOT_CONFIGURATION_FILE}"
  printf "    directory: \"%s\"\n" "${folder}" >>"${DEPENDABOT_CONFIGURATION_FILE}"
  printf "    schedule:\n" >>"${DEPENDABOT_CONFIGURATION_FILE}"
  printf "      interval: \"daily\"\n" >>"${DEPENDABOT_CONFIGURATION_FILE}"
  printf "      time: \"09:00\"\n" >>"${DEPENDABOT_CONFIGURATION_FILE}"
  printf "      timezone: \"Europe/London\"\n" >>"${DEPENDABOT_CONFIGURATION_FILE}"
  printf "    commit-message:\n" >>"${DEPENDABOT_CONFIGURATION_FILE}"
  printf "      prefix: \"terraform\"\n" >>"${DEPENDABOT_CONFIGURATION_FILE}"
  printf "      include: \"scope\"\n" >>"${DEPENDABOT_CONFIGURATION_FILE}"
  printf "    reviewers:\n" >>"${DEPENDABOT_CONFIGURATION_FILE}"
  printf "      - \"jacobwoffenden\"\n" >>"${DEPENDABOT_CONFIGURATION_FILE}"
done

if [[ "${GITHUB_ACTIONS}" == "true" ]]; then
  if git diff --exit-code "${DEPENDABOT_CONFIGURATION_FILE}" >/dev/null 2>&1; then
    echo "No difference in files, exiting."
    exit 0
  else
    mainSha=$(gh api --method GET /repos/"${GITHUB_REPOSITORY}"/contents/"${DEPENDABOT_CONFIGURATION_FILE}" --field ref="main" | jq -r '.sha')
    branchSha=$(gh api --method GET /repos/"${GITHUB_REPOSITORY}"/contents/"${DEPENDABOT_CONFIGURATION_FILE}" --field ref="${GITHUB_HEAD_REF}" | jq -r '.sha')

    if [[ "${branchSha}" != "${mainSha}" ]]; then
      echo "Branch has already been updated, using branch data"
      export apiFieldSha="${branchSha}"
    else
      echo "Branch has not been updated, using main data"
      export apiFieldSha="${mainSha}"
    fi

    gh api \
      --method PUT \
      /repos/"${GITHUB_REPOSITORY}"/contents/"${DEPENDABOT_CONFIGURATION_FILE}" \
      --field branch="${GITHUB_HEAD_REF}" \
      --field message="Committing updated Dependabot configuration" \
      --field encoding="base64" \
      --field content="$(base64 -w 0 ${DEPENDABOT_CONFIGURATION_FILE})" \
      --field sha="${apiFieldSha}"
  fi
else
  echo "Not running in GitHub Actions, skipping commit and push"
  exit 0
fi
