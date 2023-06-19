locals {
  ecr_repositories = {
    aws-ssosync = {
      name = "aws-ssosync"
      pull_accounts = [
        "655105654343" # Production
      ]
    }
  }
}
