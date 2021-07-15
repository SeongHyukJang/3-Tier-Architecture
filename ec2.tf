################# EC2 #######################
resource "aws_instance" "ec2_web" {
    ami = "ami-0b827f3319f7447c6"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.ap_private_subnet_a.id 
    availability_zone = var.az_a
    security_groups = [aws_security_group.web_sg.id]
    key_name = var.key_pair_ec2_web

    root_block_device {
        delete_on_termination = true
        volume_size = 8
        volume_type = "gp2"
    }

    tags = {
        Name = "70491_ec2_web"
    }
}

resource "aws_instance" "ec2_was"{
    ami = "ami-0b827f3319f7447c6"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.ap_private_subnet_a.id 
    availability_zone = var.az_a
    security_groups = [aws_security_group.was_sg.id]
    key_name = var.key_pair_ec2_was

    root_block_device {
        delete_on_termination = true
        volume_size = 8
        volume_type = "gp2"
    }

    tags = {
        Name = "70491_ec2_was"
    }

}
#############################################