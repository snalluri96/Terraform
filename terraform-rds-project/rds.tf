resource "aws_db_instance" "my_rds_from_existing_secret" {
  identifier            = "my-rds-instance-existing"
  allocated_storage     = 20
  engine                = "mysql"
  engine_version        = "8.0"
  instance_class        = "db.t3.micro"
  db_name               = "myappdb_existing"
  username              = jsondecode(data.aws_secretsmanager_secret_version.rds_secret_version.secret_string)["username"]
  password              = jsondecode(data.aws_secretsmanager_secret_version.rds_secret_version.secret_string)["password"]
  db_subnet_group_name  = aws_db_subnet_group.sub_grp.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  skip_final_snapshot   = true
  publicly_accessible   = false
# ... (other RDS configurations like backup, monitoring, maintenance, deletion protection) ...
depends_on = [aws_db_subnet_group.sub_grp]
}
output "rds_endpoint_existing_secret" {
  description = "The endpoint of the RDS instance using existing secret"
  value       = aws_db_instance.my_rds_from_existing_secret.endpoint
}


data "aws_secretsmanager_secret" "rds_secret" {
  name = "rdsecrets" # your manual secret name
}
data "aws_secretsmanager_secret_version" "rds_secret_version" {
  secret_id = data.aws_secretsmanager_secret.rds_secret.id
}
