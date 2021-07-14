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
  region = var.region
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
  cidr_block = var.public_subnet

  tags = {
    Name = "70491_public_subnet"
  }
}

resource "aws_subnet" "ap_private_subnet" {
  vpc_id = aws_vpc.main_vpc.id
  cidr_block = var.ap_private_subnet

  tags = {
    Name = "70491_ap_private_subnet"
  }
}

resource "aws_subnet" "db_private_subnet" {
  vpc_id = aws_vpc.main_vpc.id
  cidr_block = var.db_private_subnet

  tags = {
    Name = "70491_db_private_subnet"
  }
}
########## Internet Gateway #################
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "70491_igw"
  }
}
#############################################


#############################################
################## Route ####################
# resource "aws_route" "igw" {
#   route_table_id = aws_route_table.external_rt
#   des
# }

#############################################

############## Route Table ##################
resource "aws_route_table" "external_rt" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "70491_external_rt"
  }
}
#############################################