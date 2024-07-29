resource "aws_docdb_cluster" "mongodb" {
  cluster_identifier              = "mongodb"
  master_username                 = "YWRtaW4="
  master_password                 = "cGFzc3dvcmQ="
  backup_retention_period         = 7
  preferred_backup_window         = "00:00-01:00"
  preferred_maintenance_window    = "Sun:05:00-Sun:06:00"
  skip_final_snapshot             = true
  deletion_protection             = false
  storage_encrypted               = true
  port                            = 27017
  vpc_security_group_ids          = [aws_security_group.mongodb.id]
  db_subnet_group_name            = aws_db_subnet_group.mongodb.name
#  db_cluster_parameter_group_name = "default.docdb4.0"
  db_cluster_parameter_group_name = "docdb-skinaapi-parameter-group"
  engine                          = "docdb"
  engine_version                  = "4.0.0"
  tags = {
    "Name" = "mongodb"
  }
}

resource "aws_docdb_cluster_instance" "mongodb" {
  identifier                   = "mongodb"
  cluster_identifier           = aws_docdb_cluster.mongodb.id
  instance_class               = "db.t4g.medium"
  engine                       = "docdb"
  preferred_maintenance_window = "Sun:07:30-Sun:08:30"
  tags = {
    "Name" = "mongodb"
  }
}
resource "aws_db_subnet_group" "mongodb" {
  name        = "mongodb"
  description = "Subnets group - mongodb"
  subnet_ids = [
    aws_subnet.sub-priv-a.id,
    aws_subnet.sub-priv-b.id,
    aws_subnet.sub-pub-a.id,
    aws_subnet.sub-pub-b.id
  ]
}
resource "aws_security_group" "mongodb" {
  name        = "mongodb"
  description = "Security group - mongodb"
  vpc_id      = aws_vpc.vpc.id
  ingress {
    description = "postgres from VPC"
    from_port   = 0    #27017
    to_port     = 0    #27017
    protocol    = "-1" #"tcp"
    #cidr_blocks = [aws_vpc.vpc.cidr_block]
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    "Name" = "mongodb"
  }
}
