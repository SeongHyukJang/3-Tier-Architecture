############################# WEB NLB #################################
resource "aws_lb" "web_alb_prod" {
    name = "70491-web-alb-prod"
    internal = false
    load_balancer_type = "application"
    security_groups = [aws_security_group.alb_sg_prod.id]
    subnets = [aws_subnet.public_subnet_a_prod.id, aws_subnet.public_subnet_c_prod.id]
}

resource "aws_lb_target_group" "ec2_web_target_group_prod" {
    name = "70491-ec2-web-target-group-prod"
    port = 80
    protocol = "HTTP"
    vpc_id = aws_vpc.main_vpc_prod.id
}

resource "aws_lb_listener" "web_alb_listener_prod" {
    load_balancer_arn = aws_lb.web_alb_prod.arn
    port = "80"
    protocol = "HTTP"

    default_action {
      type = "forward"
      target_group_arn = aws_lb_target_group.ec2_web_target_group_prod.arn
    }
  
}

#######################################################################
############################# WAS NLB #################################
resource "aws_lb" "was_elb_prod" {
    name = "70491-was-elb-prod"
    internal = true
    load_balancer_type = "network"
    subnets = [aws_subnet.ap_private_subnet_a_prod.id, aws_subnet.ap_private_subnet_c_prod.id]
}

resource "aws_lb_target_group" "ec2_was_target_group_prod" {
    name = "70491-ec2-was-target-group-prod"
    port = 80
    protocol = "TCP"
    vpc_id = aws_vpc.main_vpc_prod.id
}

resource "aws_lb_listener" "was_alb_listener_prod" {
    load_balancer_arn = aws_lb.was_elb_prod.arn
    port = "80"
    protocol = "TCP"

    default_action {
        type = "forward"
        target_group_arn = aws_lb_target_group.ec2_was_target_group_prod.arn
    }
  
}

#######################################################################