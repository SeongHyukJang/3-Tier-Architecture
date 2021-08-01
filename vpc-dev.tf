################# VPC #######################
resource "aws_vpc" "main_vpc_dev" {
  cidr_block = var.vpc_cidr_dev

  tags = {
    "Name" = "70491_vpc_dev"
  }
}
#############################################
################# Subnet ####################
resource "aws_subnet" "public_subnet_a_dev" {
  vpc_id = aws_vpc.main_vpc_dev.id
  cidr_block = var.public_subnet_a_dev
  availability_zone = var.az_a

  tags = {
    Name = "70491_public_subnet_a_dev"
  }
}

resource "aws_subnet" "public_subnet_c_dev" {
  vpc_id = aws_vpc.main_vpc_dev.id
  cidr_block = var.public_subnet_c_dev
  availability_zone = var.az_c

  tags = {
    Name = "70491_public_subnet_c_dev"
  }
}

resource "aws_subnet" "ap_private_subnet_a_dev" {
  vpc_id = aws_vpc.main_vpc_dev.id
  cidr_block = var.ap_private_subnet_a_dev
  availability_zone = var.az_a

  tags = {
    Name = "70491_ap_private_subnet_a_dev"
  }
}

resource "aws_subnet" "ap_private_subnet_c_dev" {
  vpc_id = aws_vpc.main_vpc_dev.id
  cidr_block = var.ap_private_subnet_c_dev
  availability_zone = var.az_c

  tags = {
    Name = "70491_ap_private_subnet_c_dev"
  }
}

resource "aws_subnet" "db_private_subnet_a_dev" {
  vpc_id = aws_vpc.main_vpc_dev.id
  cidr_block = var.db_private_subnet_a_dev
  availability_zone = var.az_a

  tags = {
    Name = "70491_db_private_subnet_a_dev"
  }
}

resource "aws_subnet" "db_private_subnet_c_dev" {
  vpc_id = aws_vpc.main_vpc_dev.id
  cidr_block = var.db_private_subnet_c_dev
  availability_zone = var.az_c

  tags = {
    Name = "70491_db_private_subnet_c_dev"
  }
}

#############################################
########## Internet Gateway #################
resource "aws_internet_gateway" "igw_dev" {
  vpc_id = aws_vpc.main_vpc_dev.id

  tags = {
    Name = "70491_igw_dev"
  }
}
#############################################
############### NAT Gateway #################
resource "aws_eip" "nat_ip_a_dev" {
  vpc = true
}
resource "aws_nat_gateway" "nat_dev" {
  allocation_id = aws_eip.nat_ip_a_dev.id
  connectivity_type = "public"
  subnet_id = aws_subnet.public_subnet_a_dev.id
  tags = {
    Name = "70491_nat_dev"
  }
}
#############################################
############## Route Table ##################
resource "aws_route_table" "external_rt_dev" {
  vpc_id = aws_vpc.main_vpc_dev.id

  tags = {
    Name = "70491_external_rt_dev"
  }
}
resource "aws_route_table" "internal_rt_ap_dev" {
  vpc_id = aws_vpc.main_vpc_dev.id

  tags = {
    Name = "70491_internal_rt_ap_dev"
  } 
}
resource "aws_route_table" "internal_rt_db_dev" {
  vpc_id = aws_vpc.main_vpc_dev.id

  tags = {
    Name = "70491_internal_rt_db_dev"
  } 
}
#############################################
################# Route #####################
resource "aws_route" "ext_route" {
  route_table_id = aws_route_table.external_rt_dev.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.igw_dev.id
}
resource "aws_route" "int_route_nat_ap" {
  route_table_id = aws_route_table.internal_rt_ap_dev.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.nat_dev.id
}
resource "aws_route" "int_route_nat_db" {
  route_table_id = aws_route_table.internal_rt_db_dev.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.nat_dev.id
}
#############################################
########### Route Table Association #########
resource "aws_route_table_association" "ext_rt_subnet_a_dev" {
  subnet_id = aws_subnet.public_subnet_a_dev.id
  route_table_id = aws_route_table.external_rt_dev.id
}

resource "aws_route_table_association" "ext_rt_subnet_c_dev" {
  subnet_id = aws_subnet.public_subnet_c_dev.id
  route_table_id = aws_route_table.external_rt_dev.id
}

resource "aws_route_table_association" "int_rt_subnet_ap_a_dev" {
  subnet_id = aws_subnet.ap_private_subnet_a_dev.id
  route_table_id = aws_route_table.internal_rt_ap_dev.id
}

resource "aws_route_table_association" "int_rt_subnet_ap_c_dev" {
  subnet_id = aws_subnet.ap_private_subnet_c_dev.id
  route_table_id = aws_route_table.internal_rt_ap_dev.id
}

resource "aws_route_table_association" "int_rt_subnet_db_a_dev" {
  subnet_id = aws_subnet.db_private_subnet_a_dev.id
  route_table_id = aws_route_table.internal_rt_db_dev.id
}

resource "aws_route_table_association" "int_rt_subnet_db_c_dev" {
  subnet_id = aws_subnet.db_private_subnet_c_dev.id
  route_table_id = aws_route_table.internal_rt_db_dev.id
}
#############################################