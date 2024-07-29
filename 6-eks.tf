##Role e policy para anexar ao EKS
resource "aws_iam_role" "skinaapi_eks-cluster" {
  name = "skinaapi_eks-cluster"
  tags = {
    "Name" = "skinaapi_eks-cluster"
  }

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}
resource "aws_iam_role_policy_attachment" "skinaapi_eks-cluster-policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.skinaapi_eks-cluster.name
}
resource "aws_iam_role_policy_attachment" "skinaapi_eks-cluster-policy2" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.skinaapi_eks-cluster.name
}
resource "aws_iam_role_policy_attachment" "skinaapi_eks-cluster-policy3" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = aws_iam_role.skinaapi_eks-cluster.name
}


##Criacao do EKS
resource "aws_eks_cluster" "skinaapi_eks-cluster" {
  name     = "skinaapi_eks-cluster"
  version  = 1.25
  role_arn = aws_iam_role.skinaapi_eks-cluster.arn
  tags = {
    "Name" = "skinaapi_eks-cluster"
  }

  vpc_config {

    endpoint_private_access = true
    endpoint_public_access  = true
    public_access_cidrs     = ["0.0.0.0/0"]

    subnet_ids = [
      aws_subnet.skinaapi_sub-priv-a.id,
      aws_subnet.skinaapi_sub-priv-b.id,
      aws_subnet.skinaapi_sub-pub-a.id,
      aws_subnet.skinaapi_sub-pub-b.id
    ]
  }

  depends_on = [
    aws_iam_role_policy_attachment.skinaapi_eks-cluster-policy,
    aws_iam_role_policy_attachment.skinaapi_eks-cluster-policy2,
    aws_iam_role_policy_attachment.skinaapi_eks-cluster-policy3
  ]
}