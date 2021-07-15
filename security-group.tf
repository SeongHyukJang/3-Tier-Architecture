resource "aws_security_group" "web_sg" {
    name = "web_sg"
    description = "security group for web server"
    vpc_id = aws_vpc.main_vpc.id

    ingress {
        description = "HTTPS"
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = [aws_vpc.main.cidr_block]
        ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
    }

    ingress {
        description = "HTTP"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = [aws_vpc.main.cidr_block]
        ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
    }

    ingress {
        description = "SSH"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = [aws_vpc.main.cidr_block]
        ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
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
    name = "web_sg"
    description = "security group for web server"
    vpc_id = aws_vpc.main_vpc.id

    ingress {
        description = "MySQL"
        from_port = 3306
        to_port = 3306
        protocol = "tcp"
        cidr_blocks = [aws_vpc.main.cidr_block]
        ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
    }

    ingress {
        description = "SSH"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = [aws_vpc.main.cidr_block]
        ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
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

