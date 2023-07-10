resource "aws_iam_role" "adaptor_execution" {
  name = "gp2gp_adaptor_execution"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_role_policy" "adaptor_execution_dynamodb" {
  role = aws_iam_role.adaptor_execution.id
  policy = data.aws_iam_policy_document.dynamodb.json
}

resource "aws_iam_role_policy" "adaptor_execution_s3" {
  role = aws_iam_role.adaptor_execution.id
  policy = data.aws_iam_policy_document.s3.json
}

resource "aws_iam_role" "ecs_task_execution_role" {
  name = "gp2gp_ps_ecs_execution"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_role_policy" "ecs_task_execution_role_policy" {
  name = "gp2gp_ps_ecs_execution_policy"
  role = aws_iam_role.ecs_task_execution_role.id
  policy = data.aws_iam_policy_document.ecs_task_execution
}

resource "aws_iam_role_policy" "ecs_logging_role_policy" {
  name = "gp2gp_ps_ecs_logging_policy"
  role = aws_iam_role.ecs_task_execution_role.id
  policy = data.aws_iam_policy_document.ecs_logging.json
}

resource "aws_iam_role_policy" "mq_permissions" {
  name = "mq_permissions_policy"
  role = aws_iam_role.ecs_task_execution_role.id
  policy = data.aws_iam_policy_document.mq_permissions.json
}

resource "aws_iam_role_policy" "secret_store_permissions" {
  name = "secret_store_permissions_policy"
  role = aws_iam_role.ecs_task_execution_role.id
  policy = data.aws_iam_policy_document.secret_store_permissions.json
}

resource "aws_iam_role_policy" "s3_permissions" {
  name = "s3_policy"
  role = aws_iam_role.ecs_task_execution_role.id
  policy = data.aws_iam_policy_document.s3.json
}
