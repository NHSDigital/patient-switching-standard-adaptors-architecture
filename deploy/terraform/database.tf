resource "aws_db_subnet_group" "ps_db_subnet_group" {
  name       = "ps_db_subnet_group"
  subnet_ids = [for subnet in aws_subnet.nia_gp2gp_public_subnet : subnet.id]
}

resource "aws_db_instance" "ps_db" {
  allocated_storage           = 10
  engine                      = "postgres"
  engine_version              = "14.1"
  instance_class              = "db.t3.micro"
  username                    = "postgres"
  password = var.POSTGRES_PASSWORD
  #  manage_master_user_password = true
  db_subnet_group_name = aws_db_subnet_group.ps_db_subnet_group.name
  vpc_security_group_ids = [aws_security_group.ps_db_migration.id]
  publicly_accessible = true
  skip_final_snapshot = true
}