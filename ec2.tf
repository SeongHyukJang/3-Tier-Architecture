################# EC2 #######################
resource "aws_instance" "ec2_web_a" {
  ami = "ami-0b827f3319f7447c6"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.ap_private_subnet_a.id 
  availability_zone = var.az_a

  tags = {
    Name = "70491_ec2_web_a"
  }
}
#############################################