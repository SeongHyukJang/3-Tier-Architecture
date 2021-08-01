################# VPC #######################
resource "aws_vpc" "main_vpc_prod" {
  cidr_block = var.vpc_cidr_prod

  tags = {
    "Name" = "70491_vpc_prod"
  }
}
#############################################
################# Subnet ####################
resource "aws_subnet" "public_subnet_a_prod" {
  vpc_id = aws_vpc.main_vpc_prod.id
  cidr_block = var.public_subnet_a_prod
  availability_zone = var.az_a

  tags = {
    Name = "70491_public_subnet_a_prod"
  }
}

resource "aws_subnet" "public_subnet_c_prod" {
  vpc_id = aws_vpc.main_vpc_prod.id
  cidr_block = var.public_subnet_c_prod
  availability_zone = var.az_c

  tags = {
    Name = "70491_public_subnet_c_prod"
  }
}


resource "aws_subnet" "ap_private_subnet_a_prod" {
  vpc_id = aws_vpc.main_vpc_prod.id
  cidr_block = var.ap_private_subnet_a_prod
  availability_zone = var.az_a

  tags = {
    Name = "70491_ap_private_subnet_a_prod"
  }
}

resource "aws_subnet" "ap_private_subnet_c_prod" {
  vpc_id = aws_vpc.main_vpc_prod.id
  cidr_block = var.ap_private_subnet_c_prod
  availability_zone = var.az_c

  tags = {
    Name = "70491_ap_private_subnet_c_prod"
  }
}

resource "aws_subnet" "db_private_subnet_a_prod" {
  vpc_id = aws_vpc.main_vpc_prod.id
  cidr_block = var.db_private_subnet_a_prod
  availability_zone = var.az_a

  tags = {
    Name = "70491_db_private_subnet_a_prod"
  }
}

resource "aws_subnet" "db_private_subnet_c_prod" {
  vpc_id = aws_vpc.main_vpc_prod.id
  cidr_block = var.db_private_subnet_c_prod
  availability_zone = var.az_c

  tags = {
    Name = "70491_db_private_subnet_c_prod"
  }
}

#############################################
########## Internet Gateway #################
resource "aws_internet_gateway" "igw_prod" {
  vpc_id = aws_vpc.main_vpc_prod.id

  tags = {
    Name = "70491_igw_prod"
  }
}
#############################################
############### NAT Gateway #################
resource "aws_eip" "nat_ip_a_prod" {
  vpc = true
}
resource "aws_nat_gateway" "nat_prod" {
  allocation_id = aws_eip.nat_ip_a_prod.id
  connectivity_type = "public"
  subnet_id = aws_subnet.public_subnet_a_prod.id
  tags = {
    Name = "70491_nat_prod"
  }
}
#############################################
############## Route Table ##################
resource "aws_route_table" "external_rt_prod" {
  vpc_id = aws_vpc.main_vpc_prod.id

  tags = {
    Name = "70491_external_rt_prod"
  }
}
resource "aws_route_table" "internal_rt_ap_prod" {
  vpc_id = aws_vpc.main_vpc_prod.id

  tags = {
    Name = "70491_internal_rt_ap_prod"
  } 
}
resource "aws_route_table" "internal_rt_db_prod" {
  vpc_id = aws_vpc.main_vpc_prod.id

  tags = {
    Name = "70491_internal_rt_db_prod"
  } 
}
#############################################
################# Route #####################
resource "aws_route" "ext_route_prod" {
  route_table_id = aws_route_table.external_rt_prod.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.igw_prod.id
}
resource "aws_route" "int_route_nat_ap_prod" {
  route_table_id = aws_route_table.internal_rt_ap_prod.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.nat_prod.id
}
resource "aws_route" "int_route_nat_db_prod" {
  route_table_id = aws_route_table.internal_rt_db_prod.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.nat_prod.id
}
#############################################
########### Route Table Association #########
resource "aws_route_table_association" "ext_rt_subnet_a_prod" {
  subnet_id = aws_subnet.public_subnet_a_prod.id
  route_table_id = aws_route_table.external_rt_prod.id
}
resource "aws_route_table_association" "ext_rt_subnet_c_prod" {
  subnet_id = aws_subnet.public_subnet_c_prod.id
  route_table_id = aws_route_table.external_rt_prod.id
}
resource "aws_route_table_association" "int_rt_subnet_ap_a_prod" {
  subnet_id = aws_subnet.ap_private_subnet_a_prod.id
  route_table_id = aws_route_table.internal_rt_ap_prod.id
}
resource "aws_route_table_association" "int_rt_subnet_ap_c_prod" {
  subnet_id = aws_subnet.ap_private_subnet_c_prod.id
  route_table_id = aws_route_table.internal_rt_ap_prod.id
}
resource "aws_route_table_association" "int_rt_subnet_db_a_prod" {
  subnet_id = aws_subnet.db_private_subnet_a_prod.id
  route_table_id = aws_route_table.internal_rt_db_prod.id
}
resource "aws_route_table_association" "int_rt_subnet_db_c_prod" {
  subnet_id = aws_subnet.db_private_subnet_c_prod.id
  route_table_id = aws_route_table.internal_rt_db_prod.id
}
#############################################