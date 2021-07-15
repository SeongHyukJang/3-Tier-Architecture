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
  cidr_block = var.vpc_cidr

  tags = {
    "Name" = "70491_vpc"
  }
}
#############################################
################# Subnet ####################
resource "aws_subnet" "public_subnet_a" {
  vpc_id = aws_vpc.main_vpc.id
  cidr_block = var.public_subnet_a
  availability_zone = var.az_a

  tags = {
    Name = "70491_public_subnet_a"
  }
}

resource "aws_subnet" "public_subnet_c" {
  vpc_id = aws_vpc.main_vpc.id
  cidr_block = var.public_subnet_c
  availability_zone = var.az_c

  tags = {
    Name = "70491_public_subnet_c"
  }
}


resource "aws_subnet" "ap_private_subnet_a" {
  vpc_id = aws_vpc.main_vpc.id
  cidr_block = var.ap_private_subnet_a
  availability_zone = var.az_a

  tags = {
    Name = "70491_ap_private_subnet_a"
  }
}

resource "aws_subnet" "ap_private_subnet_c" {
  vpc_id = aws_vpc.main_vpc.id
  cidr_block = var.ap_private_subnet_c
  availability_zone = var.az_c

  tags = {
    Name = "70491_ap_private_subnet_c"
  }
}

resource "aws_subnet" "db_private_subnet_a" {
  vpc_id = aws_vpc.main_vpc.id
  cidr_block = var.db_private_subnet_a
  availability_zone = var.az_a

  tags = {
    Name = "70491_db_private_subnet_a"
  }
}

resource "aws_subnet" "db_private_subnet_c" {
  vpc_id = aws_vpc.main_vpc.id
  cidr_block = var.db_private_subnet_c
  availability_zone = var.az_c

  tags = {
    Name = "70491_db_private_subnet_c"
  }
}

#############################################
########## Internet Gateway #################
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "70491_igw"
  }
}
#############################################
############### NAT Gateway #################
resource "aws_eip" "nat_ip_a" {
  vpc = true
}
resource "aws_nat_gateway" "nat_a" {
  allocation_id = aws_eip.nat_ip_a.id
  connectivity_type = "public"
  subnet_id = aws_subnet.public_subnet_a.id
  tags = {
    Name = "70491_nat_a"
  }
}
resource "aws_eip" "nat_ip_c" {
  vpc = true
}
resource "aws_nat_gateway" "nat_c" {
  allocation_id = aws_eip.nat_ip_c.id
  connectivity_type = "public"
  subnet_id = aws_subnet.public_subnet_c.id
  tags = {
    Name = "70491_nat_c"
  }
}
#############################################
############## Route Table ##################
resource "aws_route_table" "external_rt" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "70491_external_rt"
  }
}

resource "aws_route_table" "internal_rt" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "70491_internal_rt"
  } 
}
#############################################
################# Route #####################
resource "aws_route" "ext_route" {
  route_table_id = aws_route_table.external_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.igw.id
}
resource "aws_route" "int_route_nat_a" {
  route_table_id = aws_route_table.internal_rt.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.nat_a.id
}
resource "aws_route" "int_route_nat_c" {
  route_table_id = aws_route_table.internal_rt.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.nat_c.id
}
#############################################
########### Route Table Association #########
resource "aws_route_table_association" "ext_rt_subnet_a" {
  subnet_id = aws_subnet.public_subnet_a.id
  route_table_id = aws_route_table.external_rt.id
}
resource "aws_route_table_association" "ext_rt_subnet_c" {
  subnet_id = aws_subnet.public_subnet_c.id
  route_table_id = aws_route_table.external_rt.id
}
resource "aws_route_table_association" "int_rt_subnet_ap_a" {
  subnet_id = aws_subnet.ap_private_subnet_a.id
  route_table_id = aws_route_table.internal_rt.id
}
resource "aws_route_table_association" "int_rt_subnet_ap_c" {
  subnet_id = aws_subnet.ap_private_subnet_c.id
  route_table_id = aws_route_table.internal_rt.id
}
resource "aws_route_table_association" "int_rt_subnet_db_a" {
  subnet_id = aws_subnet.db_private_subnet_a.id
  route_table_id = aws_route_table.internal_rt.id
}
resource "aws_route_table_association" "int_rt_subnet_db_c" {
  subnet_id = aws_subnet.db_private_subnet_c.id
  route_table_id = aws_route_table.internal_rt.id
}
#############################################