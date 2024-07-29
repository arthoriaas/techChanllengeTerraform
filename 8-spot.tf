# resource "aws_eks_fargate_profile" "skinaapi" {
#   cluster_name           = aws_eks_cluster.skinaapi_eks-cluster.name
#   fargate_profile_name   = "skinaapi"
#   pod_execution_role_arn = aws_iam_role.skinaapi_eks-fargate-profile.arn

#   # These subnets must have the following resource tag: 
#   # kubernetes.io/cluster/<CLUSTER_NAME>.
#   subnet_ids = [
#     aws_subnet.skinaapi_sub-priv-a.id,
#     aws_subnet.skinaapi_sub-priv-b.id
#   ]

#   selector {
#     namespace = "uw-dev"
#   }
# }

###DEIXAR DE SER FARGATE PROFILE E CRIAR GRUPO DE NÓS COM SPOT COM AS SEGUINTES ROLES:
# AmazonEKSWorkerNodePolicy
# AmazonEC2ContainerRegistryReadOnly
# AmazonEKS_CNI_Policy

# #Role e policy para anexar ao EKS
resource "aws_iam_role" "skinaapi_nodegroup-role" {
  name = "skinaapi_nodegroup-role"
  tags = {
    "Name" = "skinaapi_nodegroup-role"
  }

  assume_role_policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "ec2.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
POLICY
}
resource "aws_iam_role_policy_attachment" "skinaapi_nodegroup-role" {
  for_each = toset([
    "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy",
    "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly",
    "arn:aws:iam::aws:policy/AmazonEKSServicePolicy",
    "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
    "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  ])

  role       = aws_iam_role.skinaapi_nodegroup-role.name
  policy_arn = each.value
}

resource "aws_eks_node_group" "skinaapi_nodegroup" {
  cluster_name    = aws_eks_cluster.skinaapi_eks-cluster.name
  node_group_name = "skinaapi_nodegroup"
  node_role_arn   = aws_iam_role.skinaapi_nodegroup-role.arn
  instance_types  = ["t4g.nano"]
  ami_type        = "AL2_x86_64"
   remote_access {
    ec2_ssh_key = "eks-key"
  }  
  disk_size       = 10
  subnet_ids = [
    aws_subnet.skinaapi_sub-priv-a.id,
#    aws_subnet.skinaapi_sub-priv-b.id
  ]

#capacity_type = "SPOT"
capacity_type = "ON_DEMAND"
  scaling_config {
    desired_size = 1
    max_size     = 1
    min_size     = 1
  }
  lifecycle {
    prevent_destroy = false
  }
  update_config {
    max_unavailable_percentage = 70
  }

  depends_on = [aws_iam_role_policy_attachment.skinaapi_nodegroup-role]
  tags = {
    "Name" = "skinaapi_nodegroup"
  }
}
