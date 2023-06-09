#resource "aws_ssm_parameter" "AZURE_STORAGE_CONNECTION_STRING" {
#  name        = "/gp2gp_ps_daisychain/AZURE_STORAGE_CONNECTION_STRING"
#  type        = "SecureString"
#  value       = var.AZURE_STORAGE_CONNECTION_STRING
#}

resource "aws_ssm_parameter" "GP2GP_AMQP_PASSWORD" {
  name        = "/gp2gp_ps_daisychain/GP2GP_AMQP_PASSWORD"
  type        = "SecureString"
  value       = var.GP2GP_AMQP_PASSWORD
}

resource "aws_ssm_parameter" "GP2GP_AMQP_USERNAME" {
  name        = "/gp2gp_ps_daisychain/GP2GP_AMQP_USERNAME"
  type        = "SecureString"
  value       = var.GP2GP_AMQP_USERNAME
}

resource "aws_ssm_parameter" "GP2GP_SSL_TRUST_STORE_PASSWORD" {
  name        = "/gp2gp_ps_daisychain/GP2GP_SSL_TRUST_STORE_PASSWORD"
  type        = "SecureString"
  value       = var.GP2GP_SSL_TRUST_STORE_PASSWORD
}
resource "aws_ssm_parameter" "GP2GP_TRANSLATOR_USER_DB_PASSWORD" {
  name        = "/gp2gp_ps_daisychain/GP2GP_TRANSLATOR_USER_DB_PASSWORD"
  type        = "SecureString"
  value       = var.GP2GP_TRANSLATOR_USER_DB_PASSWORD
}
resource "aws_ssm_parameter" "GPC_FACADE_USER_DB_PASSWORD" {
  name        = "/gp2gp_ps_daisychain/GPC_FACADE_USER_DB_PASSWORD"
  type        = "SecureString"
  value       = var.GPC_FACADE_USER_DB_PASSWORD
}
resource "aws_ssm_parameter" "MHS_AMQP_PASSWORD" {
  name        = "/gp2gp_ps_daisychain/MHS_AMQP_PASSWORD"
  type        = "SecureString"
  value       = var.MHS_AMQP_PASSWORD
}
resource "aws_ssm_parameter" "MHS_AMQP_USERNAME" {
  name        = "/gp2gp_ps_daisychain/MHS_AMQP_USERNAME"
  type        = "SecureString"
  value       = var.MHS_AMQP_USERNAME
}
resource "aws_ssm_parameter" "MHS_SECRET_CA_CERTS" {
  name        = "/gp2gp_ps_daisychain/MHS_SECRET_CA_CERTS"
  type        = "SecureString"
  value       = trimspace(var.MHS_SECRET_CA_CERTS)
}
resource "aws_ssm_parameter" "MHS_SECRET_CLIENT_CERT" {
  name        = "/gp2gp_ps_daisychain/MHS_SECRET_CLIENT_CERT"
  type        = "SecureString"
  value       = trimspace(var.MHS_SECRET_CLIENT_CERT)
}
resource "aws_ssm_parameter" "MHS_SECRET_CLIENT_KEY" {
  name        = "/gp2gp_ps_daisychain/MHS_SECRET_CLIENT_KEY"
  type        = "SecureString"
  value       = trimspace(var.MHS_SECRET_CLIENT_KEY)
}
resource "aws_ssm_parameter" "MHS_SECRET_INBOUND_QUEUE_PASSWORD" {
  name        = "/gp2gp_ps_daisychain/MHS_SECRET_INBOUND_QUEUE_PASSWORD"
  type        = "SecureString"
  value       = var.MHS_SECRET_INBOUND_QUEUE_PASSWORD
}
resource "aws_ssm_parameter" "MHS_SECRET_INBOUND_QUEUE_USERNAME" {
  name        = "/gp2gp_ps_daisychain/MHS_SECRET_INBOUND_QUEUE_USERNAME"
  type        = "SecureString"
  value       = var.MHS_SECRET_INBOUND_QUEUE_USERNAME
}
resource "aws_ssm_parameter" "MHS_SECRET_PARTY_KEY" {
  name        = "/gp2gp_ps_daisychain/MHS_SECRET_PARTY_KEY"
  type        = "SecureString"
  value       = var.MHS_SECRET_PARTY_KEY
}
resource "aws_ssm_parameter" "POSTGRES_PASSWORD" {
  name        = "/gp2gp_ps_daisychain/POSTGRES_PASSWORD"
  type        = "SecureString"
  value       = var.POSTGRES_PASSWORD
}
resource "aws_ssm_parameter" "PS_AMQP_PASSWORD" {
  name        = "/gp2gp_ps_daisychain/PS_AMQP_PASSWORD"
  type        = "SecureString"
  value       = var.PS_AMQP_PASSWORD
}
resource "aws_ssm_parameter" "PS_AMQP_USERNAME" {
  name        = "/gp2gp_ps_daisychain/PS_AMQP_USERNAME"
  type        = "SecureString"
  value       = var.PS_AMQP_USERNAME
}
resource "aws_ssm_parameter" "PS_DB_OWNER_NAME" {
  name        = "/gp2gp_ps_daisychain/PS_DB_OWNER_NAME"
  type        = "SecureString"
  value       = var.PS_DB_OWNER_NAME
}
resource "aws_ssm_parameter" "STORAGE_SECRET" {
  name        = "/gp2gp_ps_daisychain/STORAGE_SECRET"
  type        = "SecureString"
  value       = var.STORAGE_SECRET
}