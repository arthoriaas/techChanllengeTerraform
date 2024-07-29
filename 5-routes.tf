##criando rota privada
resource "aws_route_table" "skinaapi_rt-priv" {
  vpc_id = aws_vpc.skinaapi_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.skinaapi_nat.id
  }

  tags = {
    "Name" = "skinaapi_rt-priv"
  }
}
resource "aws_route_table_association" "skinaapi_assoc-priv-a" {
  subnet_id      = aws_subnet.skinaapi_sub-priv-a.id
  route_table_id = aws_route_table.skinaapi_rt-priv.id
}
resource "aws_route_table_association" "skinaapi_assoc-priv-b" {
  subnet_id      = aws_subnet.skinaapi_sub-priv-b.id
  route_table_id = aws_route_table.skinaapi_rt-priv.id
}

##criando rota publica
resource "aws_route_table" "skinaapi_rt-pub" {
  vpc_id = aws_vpc.skinaapi_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.skinaapi_igw.id
  }

  tags = {
    "Name" = "skinaapi_rt-pub"
  }
}
resource "aws_route_table_association" "skinaapi_assoc-pub-a" {
  subnet_id      = aws_subnet.skinaapi_sub-pub-a.id
  route_table_id = aws_route_table.skinaapi_rt-pub.id
}
resource "aws_route_table_association" "skinaapi_assoc-pub-b" {
  subnet_id      = aws_subnet.skinaapi_sub-pub-b.id
  route_table_id = aws_route_table.skinaapi_rt-pub.id
}

