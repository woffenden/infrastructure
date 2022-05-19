#### VPC

resource "aws_vpc" "this" {
  cidr_block = "10.50.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "shared-services"
  }
}

#### Internet Gateway

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "shared-services"
  }
}

#### Public Subnets

resource "aws_subnet" "public_aza" {
  availability_zone = "eu-west-2a"
  vpc_id     = aws_vpc.this.id
  cidr_block = "10.50.0.0/24"

  tags = {
    Name = "shared-services-public-eu-west-2a"
  }
}

resource "aws_route_table" "public_aza" {
  vpc_id = aws_vpc.this.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }
  tags = {
    Name = "shared-services-public-eu-west-2a"
  }
}

resource "aws_route_table_association" "public_aza" {
  route_table_id = aws_route_table.public_aza.id
  subnet_id      = aws_subnet.public_aza.id
}

#### Private Subnets

resource "aws_subnet" "private_aza" {
  availability_zone = "eu-west-2a"
  vpc_id     = aws_vpc.this.id
  cidr_block = "10.50.10.0/24"

  tags = {
    Name = "shared-services-private-eu-west-2a"
  }
}

resource "aws_route_table" "private_aza" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "shared-services-public-eu-west-2a"
  }
}

resource "aws_route" "private_aza_nat" {
  route_table_id = aws_route_table.private_aza.id
  destination_cidr_block = "0.0.0.0/0"
  network_interface_id = aws_network_interface.nat.id
}

resource "aws_route_table_association" "private_aza" {
  route_table_id = aws_route_table.private_aza.id
  subnet_id      = aws_subnet.private_aza.id
}
