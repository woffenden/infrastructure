output "vpc_id" {
  value = aws_vpc.this.id
}

output "public_aza_subnet_id" {
  value = aws_subnet.public_aza.id
}

output "private_aza_subnet_id" {
  value = aws_subnet.private_aza.id
}

output "nat_security_group_id" {
  value = aws_security_group.nat.id
}