resource "aws_eks_cluster" "eks_cluster" {
    name = "70491-eks-cluster"
    role_arn = aws_iam_role.eks_role.arn

    vpc_config {
        endpoint_public_access = true
        endpoint_private_access = false

        public_access_cidrs = ["0.0.0.0/0"]

        subnet_ids = [  aws_subnet.public_subnet_a.id,      aws_subnet.public_subnet_c.id, 
                        aws_subnet.ap_private_subnet_a.id,  aws_subnet.ap_private_subnet_c.id]
    }
}

resource "aws_eks_node_group" "web_node_group" {
    cluster_name = aws_eks_cluster.eks_cluster.name
    node_group_name = "web_node_group"
    node_role_arn = aws_iam_role.node_role.arn
    subnet_ids = [aws_subnet.ap_private_subnet_a.id, aws_subnet.ap_private_subnet_c.id]
    instance_types = ["t3.medium"]
    disk_size = 20

    scaling_config {
        desired_size = 1
        min_size = 1
        max_size = 2
    }
    depends_on = [
    aws_iam_role_policy_attachment.node_node_role_attach,
    aws_iam_role_policy_attachment.node_CNI_role_attach,
    aws_iam_role_policy_attachment.node_container_role_attach,
  ]
}