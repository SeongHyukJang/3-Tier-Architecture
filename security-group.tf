resource "aws_security_group" "alb_sg" {
    name = "alb_sg"
    description = "security group for ALB"
    vpc_id = aws_vpc.main_vpc.id

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
        Name = "70491_alb_sg"
    }
  
}


resource "aws_security_group" "web_sg" {
    name = "web_sg"
    description = "security group for WEB"
    vpc_id = aws_vpc.main_vpc.id

    ingress {
        description = "HTTPS"
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = [ var.public_subnet_a, var.public_subnet_c,
                        var.ap_private_subnet_a, var.ap_private_subnet_c]
    }

    ingress {
        description = "HTTP"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = [ var.public_subnet_a, var.public_subnet_c, 
                        var.ap_private_subnet_a, var.ap_private_subnet_c]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }

    tags = {
        Name = "70491_web_sg"
  }
}

resource "aws_security_group" "was_sg" {
    name = "was_sg"
    description = "security group for WAS"
    vpc_id = aws_vpc.main_vpc.id

    ingress {
        description = "HTTPS"
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = [ var.ap_private_subnet_a, var.ap_private_subnet_c, 
                        var.db_private_subnet_a, var.db_private_subnet_c]
    }

    ingress {
        description = "HTTP"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = [ var.ap_private_subnet_a, var.ap_private_subnet_c, 
                        var.db_private_subnet_a, var.db_private_subnet_c]
    }


    ingress {
        description = "MySQL"
        from_port = 3306
        to_port = 3306
        protocol = "tcp"
        cidr_blocks = [ var.ap_private_subnet_a, var.ap_private_subnet_c, 
                        var.db_private_subnet_a, var.db_private_subnet_c]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }

    tags = {
        Name = "70491_was_sg"
  }
}

resource "aws_security_group" "db_sg" {
    name = "db_sg"
    description = "security group for DB"
    vpc_id = aws_vpc.main_vpc.id

    ingress {
        description = "MySQL"
        from_port = 3306
        to_port = 3306
        protocol = "tcp"
        cidr_blocks = [var.ap_private_subnet_a, var.ap_private_subnet_c]
    }

    ingress {
        description = "SSH"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = [var.ap_private_subnet_a, var.ap_private_subnet_c]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }

    tags = {
        Name = "70491_db_sg"
    }
}