output "root_id" {
  value = aws_organizations_organization.this.roots[0].id
}
