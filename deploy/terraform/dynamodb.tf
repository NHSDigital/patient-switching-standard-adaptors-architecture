resource "aws_dynamodb_table" "mhs_state_table" {
  name = "mhs-state"
  hash_key = "key"
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "key"
    type = "S"
  }
}

resource "aws_dynamodb_table" "mhs_sync_async_table" {
  name = "mhs-sync-async-state"
  hash_key = "key"
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "key"
    type = "S"
  }
}