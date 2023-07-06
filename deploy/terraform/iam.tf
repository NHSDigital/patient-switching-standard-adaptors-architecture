resource "aws_iam_role" "adaptor_execution" {
  name = "gp2gp_adaptor_execution"
  assume_role_policy = jsonencode({
    Version = var.iam_policy_version
    Statement = var.iam_statement_assume_role
  })
}

resource "aws_iam_role_policy" "adaptor_execution_dyanmodb" {
  role = aws_iam_role.adaptor_execution.id
  policy = jsonencode({
    Version = var.iam_policy_version
    Statement = [
      {
        Action = [
          "dynamodb:*"
        ]
        Effect   = var.iam_role_policy_effect_allow
        Resource = var.iam_role_policy_resource_all
      },
    ]
  })
}

resource "aws_iam_role_policy" "adaptor_execution_s3" {
  role = aws_iam_role.adaptor_execution.id
  policy = jsonencode({
    Version = var.iam_policy_version
    Statement = [
      {
        Action = [
          "s3:*"
        ]
        Effect   = var.iam_role_policy_effect_allow
        Resource = var.iam_role_policy_resource_all
      },
    ]
  })
}

resource "aws_iam_role" "ecs_task_execution_role" {
  name = "gp2gp_ps_ecs_execution"
  assume_role_policy = jsonencode({
    Version = var.iam_policy_version
    Statement = var.iam_statement_assume_role
  })
}

resource "aws_iam_role_policy" "ecs_task_execution_role_policy" {
  name = "gp2gp_ps_ecs_execution_policy"
  role = aws_iam_role.ecs_task_execution_role.id
  policy = jsonencode({
    Version = var.iam_policy_version
    Statement = [
      {
        Action = [
          "ssm:GetParametersByPath",
          "ssm:GetParameters",
          "ssm:GetParameter"
        ]
        Effect   = var.iam_role_policy_effect_allow
        Resource = var.iam_role_policy_resource_all
      },
    ]
  })
}

resource "aws_iam_role_policy" "ecs_logging_role_policy" {
  name = "gp2gp_ps_ecs_logging_policy"
  role = aws_iam_role.ecs_task_execution_role.id
  policy = jsonencode({
    Version = var.iam_policy_version
    Statement = [
      {
        Action = [
          "logs:*"
        ]
        Effect = var.iam_role_policy_effect_allow
        Resource = var.iam_role_policy_resource_all
      },
    ]
  })
}

resource "aws_iam_role_policy" "mq_permissions" {
  name = "mq_permissions_policy"
  role = aws_iam_role.ecs_task_execution_role.id
  policy = jsonencode({
    Version = var.iam_policy_version
    Statement = [
      {
        Action = [
          "mq:*"
        ]
        Effect = var.iam_role_policy_effect_allow
        Resource = var.iam_role_policy_resource_all
      },
    ]
  })
}

resource "aws_iam_role_policy" "secret_store_permissions" {
  name = "secret_store_permissions_policy"
  role = aws_iam_role.ecs_task_execution_role.id
  policy = jsonencode({
    Version = var.iam_policy_version
    Statement = [
      {
        Action = [
          "secretsmanager:*",
          "ssm:*"
        ]
        Effect = var.iam_role_policy_effect_allow
        Resource = var.iam_role_policy_resource_all
      },
    ]
  })
}

resource "aws_iam_role_policy" "s3_permissions" {
  name = "s3_policy"
  role = aws_iam_role.ecs_task_execution_role.id
  policy = jsonencode({
    Version = var.iam_policy_version
    Statement = [
      {
        Action = [
          "s3:*"
        ]
        Effect = var.iam_role_policy_effect_allow
        Resource = var.iam_role_policy_resource_all
      },
    ]
  })
}
