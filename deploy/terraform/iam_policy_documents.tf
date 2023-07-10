data "aws_iam_policy_document" "assume_role" {
  statement {
    sid     = ""
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "dynamodb" {
  statement {
    effect = var.iam_role_policy_effect_allow
    resources = [var.iam_role_policy_resource_all]
    actions = ["dynamodb:*"]
  }
}

data "aws_iam_policy_document" "s3" {
  statement {
    effect    = var.iam_role_policy_effect_allow
    resources = [var.iam_role_policy_resource_all]
    actions   = ["s3:*"]
  }
}

data "aws_iam_policy_document" "ecs_task_execution" {
  statement {
    effect    = var.iam_role_policy_effect_allow
    resources = [var.iam_role_policy_resource_all]
    actions   = [
      "ssm:GetParametersByPath",
      "ssm:GetParameters",
      "ssm:GetParameter"
    ]
  }
}

data "aws_iam_policy_document" "ecs_logging" {
  statement {
    effect = var.iam_role_policy_effect_allow
    resources = [var.iam_role_policy_resource_all]
    actions = ["logs:*"]
  }
}

data "aws_iam_policy_document" "mq_permissions" {
  statement {
    effect = var.iam_role_policy_effect_allow
    resources = [var.iam_role_policy_resource_all]
    actions = ["mq:*"]
  }
}

data "aws_iam_policy_document" "secret_store_permissions" {
  statement {
    effect = var.iam_role_policy_effect_allow
    resources = [var.iam_role_policy_resource_all]
    actions = [ 
      "secretsmanager:*",
      "ssm:*"
    ]
  }
}

data "aws_iam_policy_document" "s3_permissions" {
  statement {
    effect    = var.iam_role_policy_effect_allow
    resources = [var.iam_role_policy_resource_all]
    actions   = ["s3:*"]
  }
}

