resource "aws_iam_instance_profile" "ec2_iam_profile" {
    name = "70491_iam_profile"
    role = aws_iam_role.ec2_role.name
}

resource "aws_iam_role" "ec2_role" {
    name = "70491_ec2_role"
    description = "role for EC2"

    assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role" "lambda_role" {
  name = "70491_lambda_role"
  description = "role for Lambda"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role" "codedeploy_role" {
  name = "70491_codedeploy_role"
  description = "role for codedeploy"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "",
            "Effect": "Allow",
            "Principal": {
                "Service": [
                    "codedeploy.amazonaws.com"
                ]
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
EOF
}


resource "aws_iam_role_policy_attachment" "ssm_role_attach" {
    role = aws_iam_role.ec2_role.name
    policy_arn = "arn:aws:iam::aws:policy/AmazonSSMFullAccess"
}

resource "aws_iam_role_policy_attachment" "cloudwatch_role_attach" {
    role = aws_iam_role.ec2_role.name
    policy_arn = "arn:aws:iam::aws:policy/CloudWatchFullAccess"
}



resource "aws_iam_role_policy_attachment" "lambda_s3_role_attach" {
    role = aws_iam_role.lambda_role.name
    policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_role_policy_attachment" "lambda_log_role_attach" {
    role = aws_iam_role.lambda_role.name
    policy_arn = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
}

resource "aws_iam_role_policy_attachment" "lambda_ssm_role_attach" {
    role = aws_iam_role.lambda_role.name
    policy_arn = "arn:aws:iam::aws:policy/AmazonSSMFullAccess"
}


resource "aws_iam_role_policy_attachment" "codedeploy_role_attach" {
    role = aws_iam_role.codedeploy_role.name
    policy_arn = "arn:aws:iam::aws:policy/service-role/AWSCodeDeployRole"
}