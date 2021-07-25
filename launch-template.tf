resource "aws_launch_template" "ec2_web_template" {
    name = "70491_ec2_web_template"
    description = "Web server template"
    image_id = "ami-00c6c08d5bf3a8d25"
    instance_type = "t2.micro"
    key_name = "70491_ec2_web"
    vpc_security_group_ids = [aws_security_group.web_sg.id]

    user_data = filebase64("./run_web.sh")

    iam_instance_profile {
      name = aws_iam_instance_profile.ec2_iam_profile.name
    }

    tags = {
        Name = "70491_ec2_web"
    }
}

resource "aws_launch_template" "ec2_was_template" {
    name = "70491_ec2_was_template"
    description = "WAS server template"
    image_id = "ami-0fe9723ff76850619"
    instance_type = "t2.micro"
    key_name = "70491_ec2_was"
    vpc_security_group_ids = [aws_security_group.was_sg.id]

    user_data = filebase64("./run_was.sh")

    iam_instance_profile {
      name = aws_iam_instance_profile.ec2_iam_profile.name
    }

    tags = {
        Name = "70491_ec2_was"
    }
}