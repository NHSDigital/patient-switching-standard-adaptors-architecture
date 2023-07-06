resource "aws_dynamodb_table" "mhs_state_table" {
  name = "mhs-state"
  hash_key = var.dynamodb_table_hash_key
  billing_mode = var.dynamodb_table_billing_mode
  attribute {
    name = var.dynamodb_table_hash_key
    type = var.dynamodb_attribute_type_string
  }
}

resource "aws_dynamodb_table" "mhs_sync_async_table" {
  name = "mhs-sync-async-state"
  hash_key = var.dynamodb_table_hash_key
  billing_mode = var.dynamodb_table_billing_mode
  attribute {
    name = var.dynamodb_table_hash_key
    type = var.dynamodb_attribute_type_string
  }
}