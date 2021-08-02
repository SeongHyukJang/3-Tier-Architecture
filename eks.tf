resource "aws_eks_cluster" "eks_cluster" {
    name = "70491-eks-cluster"
    role_arn = aws_iam_role.eks_role.arn

    vpc_config {
        endpoint_public_access = true
        endpoint_private_access = false

        public_access_cidrs = ["0.0.0.0/0"]

        subnet_ids = [aws_subnet.public_subnet_a.id, aws_subnet.public_subnet_c.id,
                    aws_subnet.ap_private_subent_a.id, aws_subnet.ap_private_subent_c.id]
    }
}