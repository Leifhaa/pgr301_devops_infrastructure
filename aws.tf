resource "aws_db_instance" "taskDb" {
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  name                 = "taskDb"
  username             = var.aws_db_username
  password             = var.aws_db_password
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
}