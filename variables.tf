variable "region" {
    description = "aws region"
    default = "ap-northeast-2"
}

variable "az_a" {
  description = "first AZ"
  default = "ap-northeast-2a"
}

variable "az_c" {
  description = "second AZ"
  default = "ap-northeast-2c"
}

########################## PROD #########################
variable "vpc_cidr_prod" {
    description = "aws vpc cidr block production"
    default = "10.0.0.0/16"
}

variable "public_subnet_a_prod" {
    description = "public subnet"
    default = "10.0.1.0/24"
}

variable "public_subnet_c_prod" {
    description = "public subnet"
    default = "10.0.2.0/24"
}

variable "ap_private_subnet_a_prod" {
    description = "ap private subnet"
    default = "10.0.3.0/24"
}

variable "ap_private_subnet_c_prod" {
    description = "ap private subnet"
    default = "10.0.4.0/24"
}

variable "db_private_subnet_a_prod" {
    description = "db private subnet"
    default = "10.0.5.0/24"
}

variable "db_private_subnet_c_prod" {
    description = "db private subnet"
    default = "10.0.6.0/24"
}

########################## DEV #########################
variable "vpc_cidr_dev" {
    description = "aws vpc cidr block development"
    default = "10.1.0.0/16"
}

variable "public_subnet_a_dev" {
    description = "public subnet"
    default = "10.1.1.0/24"
}

variable "ap_private_subnet_a_dev" {
    description = "ap private subnet"
    default = "10.1.2.0/24"
}

variable "db_private_subnet_a_dev" {
    description = "db private subnet"
    default = "10.1.3.0/24"
}

variable "key_pair_ec2_web" {
    default = "70491_ec2_web"
}

variable "key_pair_ec2_was" {
    default = "70491_ec2_was"
}