resource "aws_db_subnet_group" "ps_db_subnet_group" {
  name       = "ps_db_subnet_group"
  description = "PS db subnet group"
  subnet_ids = [for subnet in aws_subnet.nia_gp2gp_private_subnet : subnet.id]
}

resource "aws_db_instance" "ps_db" {
  db_name           = "ps_db"
  identifier        = "ps-db"
  allocated_storage = 10
  engine            = "postgres"
  engine_version    = "14.10"
  instance_class    = "db.t3.micro"
  username          = "postgres"
  password          = var.POSTGRES_PASSWORD
  #  manage_master_user_password = true
  db_subnet_group_name   = aws_db_subnet_group.ps_db_subnet_group.id
  vpc_security_group_ids = [aws_security_group.ps_db_sg.id]
  skip_final_snapshot    = true
}