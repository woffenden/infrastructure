/* NAT resides in public_aza */

resource "aws_security_group" "nat" {
  name = "shared-services-nat"
  vpc_id = aws_vpc.this.id

  ingress {
    description      = "Allow Traffic from VPC"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = [aws_vpc.this.cidr_block]
  }

  egress {
    description      = "Allow Traffic to Internet"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "shared-services-nat"
  }
}

####

resource "aws_network_interface" "nat" {
  subnet_id   = aws_subnet.public_aza.id
  private_ips = ["10.50.0.4"]
  source_dest_check = false

  tags = {
    Name = "shared-services-nat"
  }
}

resource "aws_network_interface_sg_attachment" "nat" {
  security_group_id    = aws_security_group.nat.id
  network_interface_id = aws_network_interface.nat.id
}

resource "aws_eip" "nat" {
  vpc = true
  network_interface = aws_network_interface.nat.id
  associate_with_private_ip = "10.50.0.4"

  tags = {
    Name = "shared-services-nat"
  }
}

####

data "aws_iam_policy_document" "nat_assume" {
  statement {
    sid = "AllowEC2Assume"
    effect = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "nat" {
  name = "shared-services-nat"
  assume_role_policy = data.aws_iam_policy_document.nat_assume.json
}

resource "aws_iam_instance_profile" "nat" {
  name = "shared-services-nat"
  role = aws_iam_role.nat.name
}

resource "aws_iam_policy_attachment" "nat_ssm" {
  name       = "AmazonSSMManagedInstanceCore"
  roles      = [aws_iam_role.nat.id]
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_instance" "nat" {
  ami = "ami-0d729d2846a86a9e7" // TODO: Replace with data source
  instance_type = "t3.micro"
  iam_instance_profile = aws_iam_instance_profile.nat.id
  user_data = file("${path.module}/src/ec2-user-data/nat.cfg")

  network_interface {
    network_interface_id = aws_network_interface.nat.id
    device_index         = 0
  }

  tags = {
    Name = "shared-services-nat"
  }
}

######################## TESTING

resource "aws_security_group" "test" {
  name = "shared-services-nat-TEST"
  vpc_id = aws_vpc.this.id

  egress {
    description      = "Allow Traffic to Internet"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "shared-services-nat-TEST"
  }
}

resource "aws_network_interface" "test" {
  subnet_id   = aws_subnet.private_aza.id
  private_ips = ["10.50.10.10"]

  tags = {
    Name = "shared-services-nat-TEST"
  }
}

resource "aws_network_interface_sg_attachment" "test" {
  security_group_id    = aws_security_group.test.id
  network_interface_id = aws_network_interface.test.id
}

resource "aws_instance" "test" {
  ami = "ami-0d729d2846a86a9e7" # Amazon Linux 2 Kernel 5.10 AMI 2.0.20220426.0 x86_64 HVM gp2 // TODO: Replace with data source
  instance_type = "t3.micro"
  iam_instance_profile = aws_iam_instance_profile.nat.id

  network_interface {
    network_interface_id = aws_network_interface.test.id
    device_index         = 0
  }

  tags = {
    Name = "shared-services-nat-TEST"
  }
}