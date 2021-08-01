resource "aws_codedeploy_app" "codedeploy_app_WEB" {
    name = "70491-codedeploy-app-WEB"
    compute_platform = "Server" 
}

resource "aws_codedeploy_deployment_group" "codedeploy_group_WEB_dev" {
    app_name = aws_codedeploy_app.codedeploy_app_WEB.name
    deployment_group_name = "70491-codedeploy-group_WEB_dev"
    deployment_config_name = "CodeDeployDefault.AllAtOnce"
    service_role_arn = aws_iam_role.codedeploy_role.arn

    autoscaling_groups = [aws_autoscaling_group.web_autoscaling_group_dev.name]
    deployment_style {
        deployment_type = "IN_PLACE"
    }
    load_balancer_info {
        target_group_info {
            name = aws_lb_target_group.ec2_web_target_group_dev.name
        }
      
    }
}

resource "aws_codedeploy_deployment_group" "codedeploy_group_WEB_prod" {
    app_name = aws_codedeploy_app.codedeploy_app_WEB.name
    deployment_group_name = "70491-codedeploy-group_WEB_prod"
    deployment_config_name = "CodeDeployDefault.AllAtOnce"
    service_role_arn = aws_iam_role.codedeploy_role.arn

    autoscaling_groups = [aws_autoscaling_group.web_autoscaling_group_prod.name]
    deployment_style {
        deployment_type = "IN_PLACE"
    }
    load_balancer_info {
        target_group_info {
            name = aws_lb_target_group.ec2_web_target_group_prod.name
        }
    }
  
}

resource "aws_codedeploy_app" "codedeploy_app_WAS" {
    name = "70491-codedeploy-app-WAS_dev"
    compute_platform = "Server"
}

resource "aws_codedeploy_deployment_group" "codedeploy_group_WAS_dev" {
    app_name = aws_codedeploy_app.codedeploy_app_WAS.name
    deployment_group_name = "70491-codedeploy-group_WAS_dev"
    deployment_config_name = "CodeDeployDefault.AllAtOnce"
    service_role_arn = aws_iam_role.codedeploy_role.arn

    autoscaling_groups = [aws_autoscaling_group.was_autoscaling_group_dev.name]
    deployment_style {
        deployment_type = "IN_PLACE"
    }
    load_balancer_info {
        target_group_info {
            name = aws_lb_target_group.ec2_was_target_group_dev.name
        }
    } 
}

resource "aws_codedeploy_deployment_group" "codedeploy_group_WAS_prod" {
    app_name = aws_codedeploy_app.codedeploy_app_WAS.name
    deployment_group_name = "70491-codedeploy-group_WAS_prod"
    deployment_config_name = "CodeDeployDefault.AllAtOnce"
    service_role_arn = aws_iam_role.codedeploy_role.arn

    autoscaling_groups = [aws_autoscaling_group.was_autoscaling_group_prod.name]
    deployment_style {
        deployment_type = "IN_PLACE"
    }
    load_balancer_info {
        target_group_info {
            name = aws_lb_target_group.ec2_was_target_group_prod.name
        }
    } 
}