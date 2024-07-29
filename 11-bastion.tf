resource "aws_eip" "skinaapi_bastion" {
#  instance = aws_spot_instance_request.skinaapi_bastion.spot_instance_id
  vpc      = true
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  filter {
    name = "name"
    values = [
      "amzn-ami-hvm-*-x86_64-gp2",
    ]
  }
  filter {
    name = "owner-alias"
    values = [
      "amazon",
    ]
  }
}

resource "aws_spot_instance_request" "skinaapi_bastion" {
  ami                         = data.aws_ami.amazon_linux.id
  instance_type               = "t2.micro"
  spot_price                  = "0.016"
  spot_type                   = "one-time"
  wait_for_fulfillment        = "true"
  subnet_id                   = aws_subnet.skinaapi_sub-pub-a.id
  security_groups             = [aws_security_group.skinaapi_bastion.id]
  associate_public_ip_address = true
  key_name                    = "newultracarkey"
#  user_data = file("12.1-template-ec2.tpl")
  root_block_device {
    delete_on_termination = true
    volume_size           = 10
    volume_type           = "gp2"
    encrypted             = true
  }
  tags = {
    "Name" = "skinaapi_bastion"
  }

#  depends_on = [aws_security_group.skinaapi_bastion]
}

resource "aws_security_group" "skinaapi_bastion" {
  name        = "skinaapi_bastion"
  description = "Security group - EC2"
  vpc_id      = aws_vpc.skinaapi_vpc.id
  ingress {
    #description = "Acesso remoto"
    from_port = 0
    to_port   = 0
    protocol  = "-1" #"tcp"
    #cidr_blocks = [aws_vpc.skinaapi_vpc.cidr_block]
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    "Name" = "skinaapi_bastion"
  }
}
