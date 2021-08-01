resource "aws_security_group" "alb_sg_prod" {
    name = "alb_sg_prod"
    description = "security group for ALB PROD"
    vpc_id = aws_vpc.main_vpc_prod.id

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
        Name = "70491_alb_sg_prod"
    }
  
}


resource "aws_security_group" "web_sg_prod" {
    name = "web_sg_prod"
    description = "security group for WEB PROD"
    vpc_id = aws_vpc.main_vpc_prod.id

    ingress {
        description = "HTTPS"
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = [ var.public_subnet_a_prod, var.public_subnet_c_prod,
                        var.ap_private_subnet_a_prod, var.ap_private_subnet_c_prod]
    }

    ingress {
        description = "HTTP"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = [ var.public_subnet_a_prod, var.public_subnet_c_prod, 
                        var.ap_private_subnet_a_prod, var.ap_private_subnet_c_prod]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }

    tags = {
        Name = "70491_web_sg_prod"
  }
}

resource "aws_security_group" "was_sg_prod" {
    name = "was_sg_prod"
    description = "security group for WAS PROD"
    vpc_id = aws_vpc.main_vpc_prod.id

    ingress {
        description = "HTTP"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = [ var.ap_private_subnet_a_prod, var.ap_private_subnet_c_prod, 
                        var.db_private_subnet_a_prod, var.db_private_subnet_c_prod]
    }

    ingress {
        description = "HTTPS"
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = [ var.ap_private_subnet_a_prod, var.ap_private_subnet_c_prod, 
                        var.db_private_subnet_a_prod, var.db_private_subnet_c_prod]
    }

    ingress {
        description = "MySQL"
        from_port = 3306
        to_port = 3306
        protocol = "tcp"
        cidr_blocks = [ var.ap_private_subnet_a_prod, var.ap_private_subnet_c_prod, 
                        var.db_private_subnet_a_prod, var.db_private_subnet_c_prod]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }

    tags = {
        Name = "70491_was_sg_prod"
  }
}

resource "aws_security_group" "db_sg_prod" {
    name = "db_sg"
    description = "security group for DB"
    vpc_id = aws_vpc.main_vpc_prod.id

    ingress {
        description = "MySQL"
        from_port = 3306
        to_port = 3306
        protocol = "tcp"
        cidr_blocks = [var.ap_private_subnet_a_prod, var.ap_private_subnet_c_prod]
    }

    ingress {
        description = "SSH"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = [var.ap_private_subnet_a_prod, var.ap_private_subnet_c_prod]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }

    tags = {
        Name = "70491_db_sg_prod"
    }
}