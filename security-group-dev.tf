resource "aws_security_group" "alb_sg_dev" {
    name = "alb_sg_dev"
    description = "security group for ALB DEV"
    vpc_id = aws_vpc.main_vpc_dev.id

    ingress {
        description = "HTTP"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }

    ingress {
        description = "HTTPS"
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }

    tags = {
        Name = "70491_alb_sg_dev"
    }
  
}


resource "aws_security_group" "web_sg_dev" {
    name = "web_sg_dev"
    description = "security group for WEB DEV"
    vpc_id = aws_vpc.main_vpc_dev.id

    ingress {
        description = "HTTPS"
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = [ var.public_subnet_a_dev,        var.public_subnet_c_dev,
                        var.ap_private_subnet_a_dev,    var.ap_private_subnet_c_dev]
    }

    ingress {
        description = "HTTP"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = [ var.public_subnet_a_dev,        var.public_subnet_c_dev,
                        var.ap_private_subnet_a_dev,    var.ap_private_subnet_c_dev]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }

    tags = {
        Name = "70491_web_sg_dev"
  }
}

resource "aws_security_group" "was_sg_dev" {
    name = "was_sg_dev"
    description = "security group for WAS DEV"
    vpc_id = aws_vpc.main_vpc_dev.id

    ingress {
        description = "HTTP"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = [ var.ap_private_subnet_a_dev, var.db_private_subnet_c_dev,
                        var.db_private_subnet_a_dev, var.db_private_subnet_c_dev]
    }

    ingress {
        description = "HTTPS"
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = [ var.ap_private_subnet_a_dev, var.db_private_subnet_c_dev,
                        var.db_private_subnet_a_dev, var.db_private_subnet_c_dev]
    }

    ingress {
        description = "MySQL"
        from_port = 3306
        to_port = 3306
        protocol = "tcp"
        cidr_blocks = [ var.ap_private_subnet_a_dev, var.ap_private_subnet_c_dev,
                        var.db_private_subnet_a_dev, var.ap_private_subnet_c_dev]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }

    tags = {
        Name = "70491_was_sg_dev"
  }
}

resource "aws_security_group" "db_sg_dev" {
    name = "db_sg_dev"
    description = "security group for DB DEV"
    vpc_id = aws_vpc.main_vpc_dev.id

    ingress {
        description = "MySQL"
        from_port = 3306
        to_port = 3306
        protocol = "tcp"
        cidr_blocks = [var.ap_private_subnet_a_dev, var.ap_private_subnet_c_dev]
    }

    ingress {
        description = "SSH"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = [var.ap_private_subnet_a_dev, var.ap_private_subnet_c_dev]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }

    tags = {
        Name = "70491_db_sg_dev"
    }
}