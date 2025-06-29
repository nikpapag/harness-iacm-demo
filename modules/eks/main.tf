
# ------------------------------------------------------------------------------
#  EKS Cluster with Private Nodes
# ------------------------------------------------------------------------------
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.10.0"

  cluster_name    = "${var.eks_cluster_name}"
  cluster_version = "1.28"

  vpc_id                         = "${var.vpc_id}"
  subnet_ids                     = ["${var.private_subnet_1}", "${var.private_subnet_2}","${var.private_subnet_3}"]
  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = true
  iam_role_arn  = "arn:aws:iam::759984737373:role/AWSServiceRoleForAmazonEKSNodegroup"

  eks_managed_node_groups = {
    private_nodes = {
      min_size     = 1
      max_size     = 3
      desired_size = 2

      instance_types = ["${var.instance_type}"]
      subnet_ids     = ["${var.private_subnet_1}","${var.private_subnet_2}", "${var.private_subnet_3}"]
      iam_role_arn = "arn:aws:iam::759984737373:role/AWSServiceRoleForAmazonEKSNodegroup"
      security_group_ids = ["${var.security_group}"]
    }
  }
  tags = {
    Name        =  "${var.eks_cluster_name}"
    Environment =  "${var.environment}"
    cost_center = "${var.cost_center}"
    Owner       = "${var.tag_owner}"
    Project     = "${var.project}"
    Terraform   = "true"
  }
}
