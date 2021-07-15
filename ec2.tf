################# EC2 #######################
resource "aws_instance" "ec2_web_a" {
    ami = "ami-0b827f3319f7447c6"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.ap_private_subnet_a.id 
    availability_zone = var.az_a
    security_groups = [aws_security_group.web_sg.id]
    key_name = var.key_pair_ec2_web_a

    root_block_device {
        delete_on_termination = true
        volume_size = 8
        volume_type = "gp2"
    }

    tags = {
        Name = "70491_ec2_web_a"
    }
}

resource "aws_instance" "ec2_web_c" {
    ami = "ami-0b827f3319f7447c6"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.ap_private_subnet_c.id
    availability_zone = var.az_c
    security_groups = [aws_security_group.web_sg.id]
    key_name = var.key_pair_ec2_web_c

    root_block_device {
        delete_on_termination = true
        volume_size = 8
        volume_type = "gp2"
    }

    tags = {
      Name = "70491_ec2_web_c"
    }
}

resource "aws_instance" "ec2_was_a"{
    ami = "ami-0b827f3319f7447c6"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.ap_private_subnet_a.id 
    availability_zone = var.az_a
    security_groups = [aws_security_group.was_sb.id]
    key_name = var.key_pair_ec2_was_a

    root_block_device {
        delete_on_termination = true
        volume_size = 8
        volume_type = "gp2"
    }

    tags = {
        Name = "70491_ec2_was_a"
    }

}

resource "aws_instance" "ec2_was_c"{
    ami = "ami-0b827f3319f7447c6"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.ap_private_subnet_c.id 
    availability_zone = var.az_c
    security_groups = [aws_security_group.was_sb.id]
    key_name = var.key_pair_ec2_was_c

    root_block_device {
        delete_on_termination = true
        volume_size = 8
        volume_type = "gp2"
    }

    tags = {
        Name = "70491_ec2_was_c"
    }
}
#############################################