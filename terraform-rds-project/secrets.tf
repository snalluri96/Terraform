resource "random_password" "db_password" {
  length  = 16
  special = true
  numeric = true
  upper   = true
  lower   = true
}

resource "aws_secretsmanager_secret" "db_secret" {
  name = "prod/rds/credentials" # Use a descriptive name, potentially with environment variable
}

resource "aws_secretsmanager_secret_version" "db_secret_version" {
  secret_id     = aws_secretsmanager_secret.db_secret.id
  secret_string = jsonencode({
    username = "admin" # You can make this a variable
    password = random_password.db_password.result
    # Add other details if needed, host, port, dbname will be known after RDS creation
  })
}