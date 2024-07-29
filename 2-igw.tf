##criando internet gateway
resource "aws_internet_gateway" "skinaapi_igw" {
  vpc_id = aws_vpc.skinaapi_vpc.id

  tags = {
    "Name" = "skinaapi_igw"
  }
}