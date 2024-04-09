
output "web_public_dns" {
  description = "The public DNS address of the web server"
  value       = aws_lb.nia_gp2gp_elb.dns_name
  depends_on  = [aws_lb.nia_gp2gp_elb]
}

output "amq_endpoint" {
  value = aws_mq_broker.gp2gp_ps_broker.instances.0.endpoints.1
}

output "ps_db_instance_url" {
  value       = local.ps_db_instance_url # "jdbc:postgresql://${aws_db_instance.ps_db.endpoint}"
  description = "PostgreSQL DB url"
}