##################################### WEB ASG ###################################################
resource "aws_autoscaling_group" "web_autoscaling_group_dev" {
    name = "70491_web_autoscaling_group_dev"
    min_size = 1
    max_size = 2
    desired_capacity = 1
    target_group_arns = [aws_lb_target_group.ec2_web_target_group_dev.arn]

    launch_template {
        id = aws_launch_template.ec2_web_template_dev.id
        version = "$Latest"
    }
    vpc_zone_identifier = [aws_subnet.ap_private_subnet_a_dev.id]

    tag {
        key = "Name"
        value = "70491_WEB_dev"
        propagate_at_launch = true
    }
}
#################################################################################################
##################################### WAS ASG ###################################################
resource "aws_autoscaling_group" "was_autoscaling_group_dev" {
    name = "70491_was_autoscaling_group_dev"
    min_size = 1
    max_size = 2
    desired_capacity = 1
    target_group_arns = [aws_lb_target_group.ec2_was_target_group_dev.arn]

    launch_template {
        id = aws_launch_template.ec2_was_template_dev.id
        version = "$Latest"
    }
    vpc_zone_identifier = [aws_subnet.ap_private_subnet_a_dev.id]

    tag {
        key = "Name"
        value = "70491_WAS_dev"
        propagate_at_launch = true
    }
}
#################################################################################################