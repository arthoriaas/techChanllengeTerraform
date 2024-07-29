##criando subnets privadas A e B
resource "aws_subnet" "skinaapi_sub-priv-a" {
  vpc_id            = aws_vpc.skinaapi_vpc.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    "Name"                                      = "skinaapi_sub-priv-a"
    "kubernetes.io/cluster/skinaapi_eks-cluster" = "shared"
  }
}
resource "aws_subnet" "skinaapi_sub-priv-b" {
  vpc_id            = aws_vpc.skinaapi_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1b"

  tags = {
    "Name"                                      = "skinaapi_sub-priv-b"
    "kubernetes.io/cluster/skinaapi_eks-cluster" = "shared"
  }
}

##criando subnets publicas A e B
resource "aws_subnet" "skinaapi_sub-pub-a" {
  vpc_id                  = aws_vpc.skinaapi_vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    "Name"                                      = "skinaapi_sub-pub-a"
    "kubernetes.io/cluster/skinaapi_eks-cluster" = "shared"
    "kubernetes.io/role/elb"                    = "1"
  }
}
resource "aws_subnet" "skinaapi_sub-pub-b" {
  vpc_id                  = aws_vpc.skinaapi_vpc.id
  cidr_block              = "10.0.3.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    "Name"                                      = "skinaapi_sub-pub-b"
    "kubernetes.io/cluster/skinaapi_eks-cluster" = "shared"
    "kubernetes.io/role/elb"                    = "1"
  }
}
