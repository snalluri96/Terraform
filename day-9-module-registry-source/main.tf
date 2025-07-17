module "db" {
  source = "terraform-aws-modules/rds/aws"
  identifier     = "demodb"
  engine         = "mysql"
  major_engine_version = "5.7"
  instance_class = "db.t3a.large"
  allocated_storage = 5
  family = "mysql5.7"
  db_name        = "demodb"
  username       = "user"
  port           = "3306"
  iam_database_authentication_enabled = true
  vpc_security_group_ids = ["sg-12345678"]
  # ... other parameters
}
