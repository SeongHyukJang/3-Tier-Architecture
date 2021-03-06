##################################### WEB ASG ###################################################
resource "aws_autoscaling_group" "web_autoscaling_group" {
    name = "70491_web_autoscaling_group"
    min_size = 2
    max_size = 4
    desired_capacity = 2
    target_group_arns = [aws_lb_target_group.ec2_web_target_group.arn]

    launch_template {
        id = aws_launch_template.ec2_web_template.id
        version = "$Latest"
    }
    vpc_zone_identifier = [aws_subnet.ap_private_subnet_a.id, aws_subnet.ap_private_subnet_c.id]

    tag {
        key = "Name"
        value = "70491_WEB"
        propagate_at_launch = true
    }
}
#################################################################################################
##################################### WAS ASG ###################################################
resource "aws_autoscaling_group" "was_autoscaling_group" {
    name = "70491_was_autoscaling_group"
    min_size = 2
    max_size = 4
    desired_capacity = 2
    target_group_arns = [aws_lb_target_group.ec2_was_target_group.arn]

    launch_template {
        id = aws_launch_template.ec2_was_template.id
        version = "$Latest"
    }
    vpc_zone_identifier = [aws_subnet.ap_private_subnet_a.id, aws_subnet.ap_private_subnet_c.id]

    tag {
        key = "Name"
        value = "70491_WAS"
        propagate_at_launch = true
    }
}
#################################################################################################