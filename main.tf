terraform {
  backend "remote" {
    organization = "skcc70491"
    workspaces {
      name = "tfc-aws-architecture"
    }
  }
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "3.49.0"
    }
  }
}

provider "aws" {
  region = "ap-northeast-2"
}

################# VPC #######################
resource "aws_vpc" "main_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    "Name" = "70491_vpc"
  }
}
#############################################

################# Subnet ####################
resource "aws_subnet" "public_subnet" {
  vpc_id = aws_vpc.main_vpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "70491_public_subnet"
  }
}

resource "aws_subnet" "ap_private_subnet" {
  vpc_id = aws_vpc.main_vpc.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "70491_ap_private_subnet"
  }
}

resource "aws_subnet" "db_private_subnet" {
  vpc_id = aws_vpc.main_vpc.id
  cidr_block = "10.0.3.0/24"

  tags = {
    Name = "70491_db_private_subnet"
  }
}
#############################################
############## Route Table ##################
# resource "aws_route_table" "external_rt" {
#   vpc_id = aws_vpc.main_vpc

# }
#############################################