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

resource "aws_iam_role_policy_attachment" "ssm_role_attach" {
    role = aws_iam_role.ec2_role.name
    policy_arn = "arn:aws:iam::aws:policy/AmazonSSMFullAccess"
}

resource "aws_iam_role_policy_attachment" "cloudwatch_role_attach" {
    role = aws_iam_role.ec2_role.name
    policy_arn = "arn:aws:iam::aws:policy/CloudWatchFullAccess"
}