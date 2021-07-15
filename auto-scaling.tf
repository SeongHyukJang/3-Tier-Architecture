resource "aws_elb" "web_elb" {
    name = "70491-web-elb"
    subnets = [aws_subnet.public_subnet_a.id, aws_subnet.public_subnet_c.id]
    instances = []

    listener {
      instance_port = 8000
      instance_protocol = "http"
      lb_port = 80
      lb_protocol = "http"
    }
}

resource "aws_launch_template" "ec2_web_template" {
    name = "70491_ec2_web_template"
    description = "Web server template"
    image_id = "ami-0b827f3319f7447c6"
    instance_type = "t2.micro"
    key_name = "70491_ec2_web"
    vpc_security_group_ids = [aws_security_group.web_sg.id]
}

resource "aws_autoscaling_group" "web_autoscaling_group" {
    name = "70491_web_autoscaling_group"
    min_size = 1
    max_size = 2
    desired_capacity = 1

    launch_template {
        id = aws_launch_template.ec2_web_template.id
    }
    vpc_zone_identifier = [aws_subnet.ap_private_subnet_a.id, aws_subnet.ap_private_subnet_c.id]
}

resource "aws_autoscaling_attachment" "autoscaling_group_elb_attachment" {
    autoscaling_group_name = aws_autoscaling_group.web_autoscaling_group.id
    elb = aws_elb.web_elb.id
}