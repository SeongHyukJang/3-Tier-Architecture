variable "region" {
    description = "aws region"
    default = "ap-northeast-2"
}

variable "vpc_cidr" {
    description = "aws vpc cidr block"
    default = "10.0.0.0/16"
}

variable "public_subnet" {
    description = "public subnet"
    default = "10.0.1.0/24"
}

variable "ap_private_subnet" {
    description = "ap private subnet"
    default = "10.0.2.0/24"
}

variable "db_private_subnet" {
    description = "db private subnet"
    default = "10.0.3.0/24"
}