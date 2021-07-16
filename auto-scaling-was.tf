resource "aws_lb" "was_elb" {
    name = "70491-was-elb"
    internal = true
    load_balancer_type = "network"
    subnets = [aws_subnet.ap_private_subnet_a.id, aws_subnet.ap_private_subnet_c.id]
}

resource "aws_lb_target_group" "ec2_was_target_group" {
    name = "70491-ec2-was-target-group"
    port = 80
    protocol = "HTTP"
    vpc_id = aws_vpc.main_vpc.id
}

resource "aws_launch_template" "ec2_was_template" {
    name = "70491_ec2_was_template"
    description = "WAS server template"
    image_id = "ami-0b827f3319f7447c6"
    instance_type = "t2.micro"
    key_name = "70491_ec2_was"
    vpc_security_group_ids = [aws_security_group.was_sg.id]
}

resource "aws_autoscaling_group" "was_autoscaling_group" {
    name = "70491_was_autoscaling_group"
    min_size = 1
    max_size = 2
    desired_capacity = 1
    target_group_arns = [aws_lb_target_group.ec2_was_target_group.arn]

    launch_template {
        id = aws_launch_template.ec2_was_template.id
        version = "$Latest"
    }
    vpc_zone_identifier = [aws_subnet.ap_private_subnet_a.id, aws_subnet.ap_private_subnet_c.id]
}