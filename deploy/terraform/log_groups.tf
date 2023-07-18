resource "aws_cloudwatch_log_group" "inbound_logs" {
  name = "/ecs/gp2gp_ps/inbound"
}

resource "aws_cloudwatch_log_group" "outbound_logs" {
  name = "/ecs/gp2gp_ps/outbound"
}

resource "aws_cloudwatch_log_group" "ps_gp2gp_translator_logs" {
  name = "/ecs/gp2gp_ps/ps_gp2gp_translator"
}

resource "aws_cloudwatch_log_group" "gp2gp_logs" {
  name = "/ecs/gp2gp_ps/gp2gp"
}

resource "aws_cloudwatch_log_group" "mongodb_logs" {
  name = "/ecs/gp2gp_ps/mongodb"
}

resource "aws_cloudwatch_log_group" "gpcc_logs" {
  name = "/ecs/gp2gp_ps/gpcc"
}

resource "aws_cloudwatch_log_group" "activemq_logs" {
  name = "/ecs/gp2gp_ps/activemq"
}

resource "aws_cloudwatch_log_group" "mock_spine_logs" {
  name = "/ecs/gp2gp_ps/mock_spine"
}

resource "aws_cloudwatch_log_group" "facade_logs" {
  name = "/ecs/gp2gp_ps/facade"
}

resource "aws_cloudwatch_log_stream" "inbound_stream" {
  name           = var.cloudwatch_log_stream_name
  log_group_name = aws_cloudwatch_log_group.inbound_logs.name
}

resource "aws_cloudwatch_log_stream" "outbound_stream" {
  name           = var.cloudwatch_log_stream_name
  log_group_name = aws_cloudwatch_log_group.outbound_logs.name
}

resource "aws_cloudwatch_log_stream" "ps_gp2gp_translator_stream" {
  name           = var.cloudwatch_log_stream_name
  log_group_name = aws_cloudwatch_log_group.ps_gp2gp_translator_logs.name
}

resource "aws_cloudwatch_log_stream" "gp2gp_stream" {
  name           = var.cloudwatch_log_stream_name
  log_group_name = aws_cloudwatch_log_group.gp2gp_logs.name
}

resource "aws_cloudwatch_log_stream" "mongodb_stream" {
  name           = var.cloudwatch_log_stream_name
  log_group_name = aws_cloudwatch_log_group.mongodb_logs.name
}

resource "aws_cloudwatch_log_stream" "gpcc_stream" {
  name           = var.cloudwatch_log_stream_name
  log_group_name = aws_cloudwatch_log_group.gpcc_logs.name
}

resource "aws_cloudwatch_log_stream" "activemq_stream" {
  name           = var.cloudwatch_log_stream_name
  log_group_name = aws_cloudwatch_log_group.activemq_logs.name
}

resource "aws_cloudwatch_log_stream" "facade_stream" {
  name           = var.cloudwatch_log_stream_name
  log_group_name = aws_cloudwatch_log_group.facade_logs.name
}