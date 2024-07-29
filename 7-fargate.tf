# resource "aws_iam_role" "skinaapi_eks-fargate-profile" {
#   name = "skinaapi_eks-fargate-profile"
#   tags = {
#     "Name" = "skinaapi_eks-fargate-profile"
#   }

#   assume_role_policy = jsonencode({
#     Statement = [{
#       Action = "sts:AssumeRole"
#       Effect = "Allow"
#       Principal = {
#         Service = "eks-fargate-pods.amazonaws.com"
#       }
#     }]
#     Version = "2012-10-17"
#   })
# }
# resource "aws_iam_role_policy_attachment" "skinaapi_eks-fargate-profile" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKSFargatePodExecutionRolePolicy"
#   role       = aws_iam_role.skinaapi_eks-fargate-profile.name
# }

# resource "aws_eks_fargate_profile" "skinaapi_fargate-profile" {
#   cluster_name           = aws_eks_cluster.skinaapi_eks-cluster.name
#   fargate_profile_name   = "skinaapi_fargate-profile"
#   pod_execution_role_arn = aws_iam_role.skinaapi_eks-fargate-profile.arn

#   # These subnets must have the following resource tag: 
#   # kubernetes.io/cluster/<CLUSTER_NAME>.
#   subnet_ids = [
#     aws_subnet.skinaapi_sub-priv-a.id,
#     aws_subnet.skinaapi_sub-priv-b.id
#   ]

#   selector {
#     namespace = "kube-system"
#   }
# }

# #USAR APENAS QUANDO CRIAR DO ZERO TERRAFORM APPLY NOVAMENTE
# data "aws_eks_cluster_auth" "skinaapi_auth" {
#   name = aws_eks_cluster.skinaapi_eks-cluster.id
# }

# resource "null_resource" "skinaapi_k8s_patcher" {
#   depends_on = [aws_eks_fargate_profile.skinaapi_fargate-profile]

#   triggers = {
#     endpoint = aws_eks_cluster.skinaapi_eks-cluster.endpoint
#     ca_crt   = base64decode(aws_eks_cluster.skinaapi_eks-cluster.certificate_authority[0].data)
#     token    = data.aws_eks_cluster_auth.skinaapi_auth.token
#   }

#   #   provisioner "local-exec" {
#   #     command = <<EOH
#   # cat >/tmp/ca.crt <<EOF
#   # ${base64decode(aws_eks_cluster.skinaapi_eks-cluster.certificate_authority[0].data)}
#   # EOF
#   # kubectl \
#   #   --server="${aws_eks_cluster.skinaapi_eks-cluster.endpoint}" \
#   #   --certificate_authority=/tmp/ca.crt \
#   #   --token="${data.aws_eks_cluster_auth.skinaapi_auth.token}" \
#   #   patch deployment coredns \
#   #   -n kube-system --type json \
#   #   -p='[{"op": "remove", "path": "/spec/template/metadata/annotations/eks.amazonaws.com~1compute-type"}]'
#   # EOH
#   #   }

#   lifecycle {
#     ignore_changes = [triggers]
#   }
# }