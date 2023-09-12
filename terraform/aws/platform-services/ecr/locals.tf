locals {
  ecr_repositories = {
    aws-ssosync = {
      name = "aws-ssosync"
      pull_accounts = [
        "749019155605" # Production
      ]
    }
  }
}
