module "organisation_guardduty" {
  source = "../../../../modules/aws/organisation-guardduty"

  depends_on = [module.organisation]
}
