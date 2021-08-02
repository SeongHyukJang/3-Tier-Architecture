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


variable "vpc_cidr" {
    description = "aws vpc cidr block"
    default = "10.0.0.0/16"
}

variable "public_subnet_a" {
    description = "public subnet"
    default = "10.0.1.0/24"
}

variable "public_subnet_c" {
    description = "public subnet"
    default = "10.0.2.0/24"
}

variable "ap_private_subnet_a" {
    description = "ap private subnet"
    default = "10.0.3.0/24"
}

variable "ap_private_subnet_c" {
    description = "ap private subnet"
    default = "10.0.4.0/24"
}

variable "db_private_subnet_a" {
    description = "db private subnet"
    default = "10.0.5.0/24"
}

variable "db_private_subnet_c" {
    description = "db private subnet"
    default = "10.0.6.0/24"
}

variable "key_pair_ec2_web" {
    default = "70491_ec2_web"
}

variable "key_pair_ec2_was" {
    default = "70491_ec2_was"
}