resource "aws_codedeploy_app" "codedeploy_app_WEB" {
    name = "70491-codedeploy-app-WEB"
    compute_platform = "Server" 
}

resource "aws_codedeploy_deployment_group" "codedeploy_group_WEB" {
    app_name = aws_codedeploy_app.codedeploy_app_WEB.name
    deployment_group_name = "70491-codedeploy-group_WEB"
    deployment_config_name = "CodeDeployDefault.AllAtOnce"
    service_role_arn = aws_iam_role.codedeploy_role.arn

    autoscaling_groups = [aws_autoscaling_group.web_autoscaling_group.name]
    deployment_style {
        deployment_type = "IN_PLACE"
    }
    load_balancer_info {
        target_group_info {
            name = aws_lb_target_group.ec2_web_target_group.name
        }
      
    }
}

resource "aws_codedeploy_app" "codedeploy_app_WAS" {
    name = "70491-codedeploy-app-WAS"
    compute_platform = "Server"
}

resource "aws_codedeploy_deployment_group" "codedeploy_group_WAS" {
    app_name = aws_codedeploy_app.codedeploy_app_WAS.name
    deployment_group_name = "70491-codedeploy-group_WAS"
    deployment_config_name = "CodeDeployDefault.AllAtOnce"
    service_role_arn = aws_iam_role.codedeploy_role.arn

    autoscaling_groups = [aws_autoscaling_group.was_autoscaling_group.name]
    deployment_style {
        deployment_type = "IN_PLACE"
    }
    load_balancer_info {
        target_group_info {
            name = aws_lb_target_group.ec2_was_target_group.name
        }
    } 
}