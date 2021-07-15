resource "aws_lb" "web_elb" {
    name = "70491-web-elb"
    internal = false
    load_balancer_type = "application"
    security_groups = [aws_security_group.web_sg.id]
    subnets = [aws_subnet.public_subnet_a.id, aws_subnet.public_subnet_c.id]
    
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
    target_group_arns = [aws_lb.web_elb.arn]

    launch_template {
        id = aws_launch_template.ec2_web_template.id
    }
    vpc_zone_identifier = [aws_subnet.ap_private_subnet_a.id, aws_subnet.ap_private_subnet_c.id]
}