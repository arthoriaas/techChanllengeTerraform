##criando ip elastico para o nat
resource "aws_eip" "skinaapi_eip" {
  vpc = true
  #depends_on = [aws_internet_gateway.skinaapi_igw]
  tags = {
    "Name" = "skinaapi_eip"
  }
}
##criando nat gateway
resource "aws_nat_gateway" "skinaapi_nat" {
  allocation_id = aws_eip.skinaapi_eip.id
  subnet_id     = aws_subnet.skinaapi_sub-pub-a.id
  depends_on    = [aws_internet_gateway.skinaapi_igw]
  tags = {
    "Name" = "skinaapi_nat"
  }
}