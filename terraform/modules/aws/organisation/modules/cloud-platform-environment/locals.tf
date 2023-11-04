locals {
  name = var.configuration.name
  # environments = var.configuration.environments
  environments = [
    for env in var.configuration.environments : {
      name = env.name
      access = [
        for acc in env.access : {
          github_team  = acc.github_team
          google_group = acc.google_group
          role         = acc.role
        }
      ]
    }
  ]
}
