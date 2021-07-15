resource "aws_lb" "web_elb" {
    name = "70491-web-elb"
    internal = false
    load_balancer_type = "application"
    security_groups = [aws_security_group.web_sg.id]
    subnets = [aws_subnet.public_subnet_a.id, aws_subnet.public_subnet_c.id]
    
}

resource "aws_lb_target_group" "ec2_web_target_group" {
    name = "70491-ec2-web-target-group"
    port = 80
    protocol = "HTTP"
    vpc_id = aws_vpc.main_vpc.id
}

resource "aws_lb_target_group_attachment" "ec2_web_target_group_attach" {
    target_group_arn = aws_lb_target_group.ec2_web_target_group.arn
    target_id = aws_instance.ec2_web.id
    port = 80
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
    target_group_arns = [aws_lb_target_group.ec2_web_target_group.arn]

    launch_template {
        id = aws_launch_template.ec2_web_template.id
        version = "$Latest"
    }
    vpc_zone_identifier = [aws_subnet.ap_private_subnet_a.id, aws_subnet.ap_private_subnet_c.id]
}