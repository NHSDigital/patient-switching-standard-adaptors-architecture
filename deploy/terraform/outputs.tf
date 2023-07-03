
output "web_public_dns" {
  description = "The public DNS address of the web server"
  value       = aws_lb.nia_gp2gp_elb.dns_name
  depends_on  = [aws_lb.nia_gp2gp_elb]
}

output "s3_state_bucket_arn" {
  value = aws_s3_bucket.ps_adaptors_tf_state.arn
  description = "The ARN of S3 state bucket"
}

output "dynamodb_state_table_name" {
  value = aws_dynamodb_table.ps_adaptors_tf_locks.name
  description = "The name of DynamoDB state table"
}

output "amq_endpoint" {
  value = aws_mq_broker.gp2gp_ps_broker.instances.0.endpoints.1
}

output "ps_db_instance_url" {
  value       = "jdbc:postgresql://${aws_db_instance.ps_db.endpoint}"
  description = "The name of DynamoDB state table"
}