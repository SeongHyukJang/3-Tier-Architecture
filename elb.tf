############################# WEB NLB #################################
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
    protocol = "HTTP"
    vpc_id = aws_vpc.main_vpc.id
}
#######################################################################