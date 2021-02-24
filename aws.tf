resource "aws_dynamodb_table" "billing-table" {
  hash_key = "UserId"
  name = "Billing"
  attribute {
    name = "UserId"
    type = "S"
  }
  attribute {
    name = "Amount"
    type = "N"
  }
}