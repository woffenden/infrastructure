locals {
  ecr_repositories = {
    aws-ssosync = {
      name      = "aws-ssosync"
      push_arns = ["arn:aws:iam::749019155605:role/github-actions"]
      pull_arns = ["arn:aws:iam::655105654343:root"]
    }
  }
}
