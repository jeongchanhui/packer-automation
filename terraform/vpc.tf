resource "aws_vpc" "sandbox-vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true

  tags = {
    Name = "sandbox-vpc"
  }
}

resource "aws_subnet" "sandbox-pub-subnet" {
  vpc_id     = aws_vpc.sandbox-vpc.id
  cidr_block = "10.0.1.0/24"
  tags = {
    Name = "sandbox-pub-subnet"
  }
}

output "vpc_id" {
  value       = aws_vpc.sandbox-vpc.id
  description = "The ID of the VPC"
}

output "subnet_id" {
  value       = aws_subnet.sandbox-pub-subnet.id
  description = "The ID of the subnet"
}
