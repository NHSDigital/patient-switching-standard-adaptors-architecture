
output "web_public_dns" {
  description = "The public DNS address of the web server"
  value       = aws_lb.nia_gp2gp_elb.dns_name
  depends_on  = [aws_lb.nia_gp2gp_elb]
}