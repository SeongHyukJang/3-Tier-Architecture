############################# WEB NLB #################################
resource "aws_lb" "web_elb" {
    name = "70491-web-elb"
    internal = false
    load_balancer_type = "application"
    security_groups = [aws_security_group.alb_sg.id]
    subnets = [aws_subnet.public_subnet_a.id, aws_subnet.public_subnet_c.id]
}

resource "aws_lb_target_group" "ec2_web_target_group" {
    name = "70491-ec2-web-target-group"
    port = 80
    protocol = "HTTP"
    vpc_id = aws_vpc.main_vpc.id
}

resource "aws_lb_listener" "web_alb_listener" {
    load_balancer_arn = aws_lb.web_elb.arn
    port = "80"
    protocol = "HTTP"

    default_action {
      type = "forward"
      target_group_arn = aws_lb_target_group.ec2_web_target_group.arn
    }
}

resource "aws_lb_listener" "web_alb_listener_https"{
    load_balancer_arn = aws_lb.web_elb.arn
    port = "443"
    protocol = "HTTPS"
    ssl_policy        = "ELBSecurityPolicy-2016-08"
    certificate_arn   = "arn:aws:acm:ap-northeast-2:533616270150:certificate/ad70a98d-9d5d-4571-be33-b83a4a5364ec"

    default_action {
      type = "forward"
      target_group_arn = aws_lb_target_group.ec2_web_target_group.arn
    }
}



#######################################################################
############################# WAS NLB #################################
resource "aws_lb" "was_elb" {
    name = "70491-was-elb"
    internal = true
    load_balancer_type = "network"
    subnets = [aws_subnet.ap_private_subnet_a.id, aws_subnet.ap_private_subnet_c.id]
}

resource "aws_lb_target_group" "ec2_was_target_group" {
    name = "70491-ec2-was-target-group"
    port = 80
    protocol = "TCP"
    vpc_id = aws_vpc.main_vpc.id
}

resource "aws_lb_listener" "was_alb_listener" {
    load_balancer_arn = aws_lb.was_elb.arn
    port = "80"
    protocol = "TCP"

    default_action {
        type = "forward"
        target_group_arn = aws_lb_target_group.ec2_was_target_group.arn
    }
  
}

#######################################################################