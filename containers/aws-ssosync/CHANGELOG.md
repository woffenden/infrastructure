<!-- markdownlint-disable MD024 -->
# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [2.1.2] - 2024-01-21

### Changed

- Updated awslabs/ssosync to 2.1.2

### Added

- `--ignore-groups` flag

- `--ignore-users` flag

## [2.1.0] - 2023-12-14

### Changed

- Updated SSOSync to 2.1.0

- Update Alpine to 3.19.0

## [2.0.3.2] - 2023-11-04

### Changed

- Remove `--group-match`, sync all the groups

## [2.0.3.1] - 2023-10-23

### Changed

- Updated Alpine and cURL version

## [2.0.3] - 2023-08-25

### Changed

- Aligned versioning with AWS SSO Sync binary

- Updated Alpine and cURL version

## [0.0.7] - 2023-06-19

### Added

- `chmod 755` the scripts

## [0.0.6] - 2023-06-19

### Added

- Switching to Lamba custom runtime image

## [0.0.5] - 2023-06-19

### Added

- Set `groups` for `--sync-method`

## [0.0.4] - 2023-06-19

### Added

- Switched to `echo` instead of `cat` for writing credentials

## [0.0.3] - 2023-06-19

### Added

- Set location of Google Credentials to `/tmp/credentials.json` as AWS Lambda can only write to `/tmp`

## [0.0.2] - 2023-06-18

### Added

- Bumping for ECR testing

## [0.0.1] - 2023-06-16

### Added

- Initial image as a proof-of-concept
