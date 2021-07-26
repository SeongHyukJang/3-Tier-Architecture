

/*
name
description
cloudwatch metric name

resource type : regional resources (alb)

region : seoul


associated aws resources (optional) -> 70491-web-elb(alb)

rules
- free rule groups
    - 

*/

resource "aws_wafv2_web_acl" "WAF_ACL" {
    name = "70491-WAF"
    description = "70491-WAF"
    scope = "REGIONAL"

    default_action {
      allow {}
    }   
}

resource "aws_wafv2_web_acl_association" "WAF_ACL_association" {
    resource_arn = aws_lb.web_elb.arn
    web_acl_arn = aws_wafv2_web_acl.WAF_ACL.arn
}