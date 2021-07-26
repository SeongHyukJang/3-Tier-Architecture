resource "aws_wafv2_web_acl" "WAF_ACL" {
    name = "70491-WAF"
    description = "70491-WAF"
    scope = "REGIONAL"

    default_action {
      allow {}
    }

    visibility_config {
        cloudwatch_metrics_enabled = true
        metric_name = "70491-WAF"
        sampled_requests_enabled = true
    }
}

resource "aws_wafv2_web_acl_association" "WAF_ACL_association" {
    resource_arn = aws_lb.web_elb.arn
    web_acl_arn = aws_wafv2_web_acl.WAF_ACL.arn
}