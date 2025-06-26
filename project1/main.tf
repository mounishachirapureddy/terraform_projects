provider "aws" {
  region = var.region
}

resource "aws_vpc" "vpc_a" {
  cidr_block = var.vpc_a_cidr

  tags = {
    Name = "${var.env}-vpc-a"
    Environment = var.env
  }
}

resource "aws_vpc" "vpc_b" {
  cidr_block = var.vpc_b_cidr

  tags = {
    Name = "${var.env}-vpc-b"
    Environment = var.env
  }
}

resource "aws_vpc_peering_connection" "peer_connection" {
  vpc_id        = aws_vpc.vpc_a.id
  peer_vpc_id   = aws_vpc.vpc_b.id
  auto_accept   = true

  tags = {
    Name        = "${var.env}-vpc-peer"
    Environment = var.env
  }
}

