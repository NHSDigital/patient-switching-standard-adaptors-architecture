provider "aws" {
  region = "eu-west-2"
}

data "aws_availability_zones" "available" {
  state = "available"
}

data "template_file" "gp2gp_ps_task_template" {
  template = "${file("../ecs_tasks/gp2gp_ps.tpl.json")}"
  vars = {

## Secrets ##
// Load these from param store

    AWS_ACCESS_KEY_ID = aws_ssm_parameter.AWS_ACCESS_KEY_ID.arn
    AWS_SECRET_ACCESS_KEY = aws_ssm_parameter.AWS_SECRET_ACCESS_KEY.arn
    AZURE_STORAGE_CONNECTION_STRING = aws_ssm_parameter.AZURE_STORAGE_CONNECTION_STRING.arn
    GP2GP_AMQP_PASSWORD = aws_ssm_parameter.GP2GP_AMQP_PASSWORD.arn
    GP2GP_AMQP_USERNAME = aws_ssm_parameter.GP2GP_AMQP_USERNAME.arn
    GP2GP_SSL_TRUST_STORE_PASSWORD = aws_ssm_parameter.GP2GP_SSL_TRUST_STORE_PASSWORD.arn
    GP2GP_TRANSLATOR_USER_DB_PASSWORD = aws_ssm_parameter.GP2GP_TRANSLATOR_USER_DB_PASSWORD.arn
    GPC_FACADE_USER_DB_PASSWORD = aws_ssm_parameter.GPC_FACADE_USER_DB_PASSWORD.arn
    MHS_AMQP_PASSWORD = aws_ssm_parameter.MHS_AMQP_PASSWORD.arn
    MHS_AMQP_USERNAME = aws_ssm_parameter.MHS_AMQP_USERNAME.arn
    MHS_SECRET_CA_CERTS = aws_ssm_parameter.MHS_SECRET_CA_CERTS.arn
    MHS_SECRET_CLIENT_CERT = aws_ssm_parameter.MHS_SECRET_CLIENT_CERT.arn
    MHS_SECRET_CLIENT_KEY = aws_ssm_parameter.MHS_SECRET_CLIENT_KEY.arn
    MHS_SECRET_INBOUND_QUEUE_PASSWORD = aws_ssm_parameter.MHS_AMQP_PASSWORD.arn
    MHS_SECRET_INBOUND_QUEUE_USERNAME = aws_ssm_parameter.MHS_AMQP_USERNAME.arn
    MHS_SECRET_PARTY_KEY = aws_ssm_parameter.MHS_SECRET_PARTY_KEY.arn
    POSTGRES_PASSWORD = aws_ssm_parameter.POSTGRES_PASSWORD.arn
    PS_AMQP_PASSWORD = aws_ssm_parameter.PS_AMQP_PASSWORD.arn
    PS_AMQP_USERNAME = aws_ssm_parameter.PS_AMQP_USERNAME.arn
    PS_DB_OWNER_NAME = aws_ssm_parameter.PS_DB_OWNER_NAME.arn
    STORAGE_SECRET = aws_ssm_parameter.STORAGE_SECRET.arn

## Environment Variables ##
// Load these from tf.vars

    AWS_REGION = var.AWS_REGION
    GP2GP_AMQP_BROKERS = var.GP2GP_AMQP_BROKERS
    GP2GP_AMQP_MAX_REDELIVERIES = var.GP2GP_AMQP_MAX_REDELIVERIES
    GP2GP_COSMOS_DB_ENABLED = var.GP2GP_COSMOS_DB_ENABLED
    GP2GP_GPC_DOCUMENTS_FHIR_BASE = var.GP2GP_GPC_DOCUMENTS_FHIR_BASE
    GP2GP_GPC_GET_TEST_URL = var.GP2GP_GPC_GET_TEST_URL
    GP2GP_GPC_GET_URL = var.GP2GP_GPC_GET_URL
    GP2GP_GPC_OVERRIDE_FROM_ASID = var.GP2GP_GPC_OVERRIDE_FROM_ASID
    GP2GP_GPC_OVERRIDE_NHS_NUMBER = var.GP2GP_GPC_OVERRIDE_NHS_NUMBER
    GP2GP_GPC_OVERRIDE_TO_ASID = var.GP2GP_GPC_OVERRIDE_TO_ASID
    GP2GP_GPC_STRUCTURED_FHIR_BASE = var.GP2GP_GPC_STRUCTURED_FHIR_BASE
    GP2GP_LARGE_ATTACHMENT_THRESHOLD = var.GP2GP_LARGE_ATTACHMENT_THRESHOLD
    GP2GP_LARGE_EHR_EXTRACT_THRESHOLD = var.GP2GP_LARGE_EHR_EXTRACT_THRESHOLD
    GP2GP_LOGGING_LEVEL = var.GP2GP_LOGGING_LEVEL
    GP2GP_MHS_INBOUND_QUEUE = var.GP2GP_MHS_INBOUND_QUEUE
    GP2GP_MHS_OUTBOUND_URL = var.GP2GP_MHS_OUTBOUND_URL
    GP2GP_MONGO_DATABASE_NAME = var.GP2GP_MONGO_DATABASE_NAME
    GP2GP_MONGO_TTL = var.GP2GP_MONGO_TTL
    GP2GP_MONGO_URI = var.GP2GP_MONGO_URI
    GP2GP_SERVER_PORT = var.GP2GP_SERVER_PORT
    GP2GP_SSL_TRUST_STORE_URL = var.GP2GP_SSL_TRUST_STORE_URL
    GP2GP_STORAGE_CONTAINER_NAME = var.GP2GP_STORAGE_CONTAINER_NAME
    GP2GP_STORAGE_TYPE = var.GP2GP_STORAGE_TYPE
    GP2GP_TRANSLATOR_SERVER_PORT = var.GP2GP_TRANSLATOR_SERVER_PORT
    GPC_CONSUMER_GPC_GET_DOCUMENT_PATH = var.GPC_CONSUMER_GPC_GET_DOCUMENT_PATH
    GPC_CONSUMER_GPC_GET_PATIENT_PATH = var.GPC_CONSUMER_GPC_GET_PATIENT_PATH
    GPC_CONSUMER_GPC_STRUCTURED_PATH = var.GPC_CONSUMER_GPC_STRUCTURED_PATH
    GPC_CONSUMER_LOGGING_LEVEL = var.GPC_CONSUMER_LOGGING_LEVEL
    GPC_CONSUMER_SDS_APIKEY = var.GPC_CONSUMER_SDS_APIKEY
    GPC_CONSUMER_SDS_URL = var.GPC_CONSUMER_SDS_URL
    GPC_CONSUMER_SEARCH_DOCUMENTS_PATH = var.GPC_CONSUMER_SEARCH_DOCUMENTS_PATH
    GPC_CONSUMER_SERVER_PORT = var.GPC_CONSUMER_SERVER_PORT
    GPC_CONSUMER_SPINE_CLIENT_CERT = var.GPC_CONSUMER_SPINE_CLIENT_CERT
    GPC_CONSUMER_SPINE_CLIENT_KEY = var.GPC_CONSUMER_SPINE_CLIENT_KEY
    GPC_CONSUMER_SPINE_ROOT_CA_CERT = var.GPC_CONSUMER_SPINE_ROOT_CA_CERT
    GPC_CONSUMER_SPINE_SUB_CA_CERT = var.GPC_CONSUMER_SPINE_SUB_CA_CERT
    GPC_CONSUMER_SSP_URL = var.GPC_CONSUMER_SSP_URL
    GPC_FACADE_SERVER_PORT = var.GPC_FACADE_SERVER_PORT
    MAX_RESYNC_RETRIES = var.MAX_RESYNC_RETRIES
    MHS_AMQP_BROKER = var.MHS_AMQP_BROKER
    MHS_AMQP_MAX_REDELIVERIES = var.MHS_AMQP_MAX_REDELIVERIES
    MHS_BASE_URL = var.MHS_BASE_URL
    MHS_DB_ENDPOINT_URL = var.MHS_DB_ENDPOINT_URL
    MHS_FORWARD_RELIABLE_ENDPOINT_URL = var.MHS_FORWARD_RELIABLE_ENDPOINT_URL
    MHS_INBOUND_HEALTHCHECK_SERVER_PORT = var.MHS_INBOUND_HEALTHCHECK_SERVER_PORT
    MHS_INBOUND_QUEUE_BROKERS = var.MHS_AMQP_BROKER
    MHS_INBOUND_QUEUE_MESSAGE_TTL_IN_SECONDS = var.MHS_INBOUND_QUEUE_MESSAGE_TTL_IN_SECONDS
    MHS_INBOUND_QUEUE_NAME = var.MHS_QUEUE_NAME
    MHS_INBOUND_USE_SSL = var.MHS_INBOUND_USE_SSL
    MHS_LOG_LEVEL = var.MHS_LOG_LEVEL
    MHS_OUTBOUND_ROUTING_LOOKUP_METHOD = var.MHS_OUTBOUND_ROUTING_LOOKUP_METHOD
    MHS_OUTBOUND_VALIDATE_CERTIFICATE = var.MHS_OUTBOUND_VALIDATE_CERTIFICATE
    MHS_QUEUE_NAME = var.MHS_QUEUE_NAME
    MHS_RESYNC_INTERVAL = var.MHS_RESYNC_INTERVAL
    MHS_SDS_API_KEY = var.MHS_SDS_API_KEY
    MHS_SDS_API_URL = var.MHS_SDS_API_URL
    MHS_SPINE_ORG_CODE = var.MHS_SPINE_ORG_CODE
    MHS_SPINE_REQUEST_MAX_SIZE = var.MHS_SPINE_REQUEST_MAX_SIZE
    MHS_SPINE_ROUTE_LOOKUP_URL = var.MHS_SPINE_ROUTE_LOOKUP_URL
    MHS_STATE_TABLE_NAME = var.MHS_STATE_TABLE_NAME
    MHS_SYNC_ASYNC_STATE_TABLE_NAME = var.MHS_SYNC_ASYNC_STATE_TABLE_NAME
    PS_AMQP_BROKER = var.PS_AMQP_BROKER
    PS_AMQP_MAX_REDELIVERIES = var.PS_AMQP_MAX_REDELIVERIES
    PS_DAISY_CHAINING_ACTIVE = var.PS_DAISY_CHAINING_ACTIVE
    PS_DB_URL = var.PS_DB_URL
    PS_LOGGING_LEVEL = var.PS_LOGGING_LEVEL
    PS_QUEUE_NAME = var.PS_QUEUE_NAME
    SERVICE_PORTS = var.MHS_INBOUND_SERVICE_PORTS
    STORAGE_CONTAINER_NAME = var.STORAGE_CONTAINER_NAME
    STORAGE_REFERENCE = var.STORAGE_REFERENCE
    STORAGE_REGION = var.STORAGE_REGION
    STORAGE_TYPE = var.STORAGE_TYPE
    SUPPORTED_FILE_TYPES = var.SUPPORTED_FILE_TYPES
    TCP_PORTS = var.MHS_INBOUND_PORT
  }
}

## VPC Module ##
// All the below can be put in to a tf module setting up the vpc
// outputs:
// - public subnet ids
// - private subnet ids

resource "aws_vpc" "nia_gp2gp_vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true

  tags = {
    Name = "nia_gp2gp_vpc"
  }
}

resource "aws_internet_gateway" "nia_gp2gp_igw" {
  vpc_id = aws_vpc.nia_gp2gp_vpc.id

  tags = {
    Name = "nia_gp2gp_igw"
  }
}

resource "aws_subnet" "nia_gp2gp_public_subnet" {
  count             = var.subnet_count.public
  cidr_block        = var.public_subnet_cidr_blocks[count.index]
  vpc_id            = aws_vpc.nia_gp2gp_vpc.id
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = "nia_gp2gp_public_subnet_${count.index}"
  }
}

resource "aws_subnet" "nia_gp2gp_private_subnet" {
  count             = var.subnet_count.private
  vpc_id            = aws_vpc.nia_gp2gp_vpc.id
  cidr_block        = var.private_subnet_cidr_blocks[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = "nia_gp2gp_private_subnet${count.index}"
  }
}

resource "aws_route_table" "nia_gp2gp_public_rt" {
  vpc_id = aws_vpc.nia_gp2gp_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.nia_gp2gp_igw.id
  }
}

resource "aws_route_table_association" "public" {
  count          = var.subnet_count.public
  route_table_id = aws_route_table.nia_gp2gp_public_rt.id
  subnet_id      = aws_subnet.nia_gp2gp_public_subnet[count.index].id
}

resource "aws_route_table" "nia_gp2gp_private_rt" {
  vpc_id = aws_vpc.nia_gp2gp_vpc.id
}

resource "aws_route_table_association" "private" {
  count          = var.subnet_count.private
  route_table_id = aws_route_table.nia_gp2gp_private_rt.id
  subnet_id      = aws_subnet.nia_gp2gp_private_subnet[count.index].id
}

resource "aws_security_group" "nia_gp2gp_dmz" {
  name        = "nia_gp2gp_api_sg"
  description = "Public security group"
  vpc_id      = aws_vpc.nia_gp2gp_vpc.id

  ingress {
    from_port   = var.http_server_port
    protocol    = "tcp"
    to_port     = var.http_server_port
    cidr_blocks = ["0.0.0.0/0"]
  }

  //TODO: restrict access to match current restrictions

  ingress {
    from_port   = var.ssh_server_port
    to_port     = var.ssh_server_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    //allow all
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "nia_gp2gp_dmz_sg"
  }
}

resource "aws_security_group" "nia_gp2gp_private" {
  name        = "nia_gp2gp_private"
  description = "Security group for private resources"
  vpc_id = aws_vpc.nia_gp2gp_vpc.id

  ingress {
    description     = "Allow HTTP traffic from only the pubic sg"
    from_port       = "80"
    protocol        = "tcp"
    to_port         = "80"
    security_groups = [aws_security_group.nia_gp2gp_dmz.id]
  }

  ingress {
    description     = "Allow HTTPS traffic from only the pubic sg"
    from_port       = "443"
    protocol        = "tcp"
    to_port         = "443"
    security_groups = [aws_security_group.nia_gp2gp_dmz.id]
  }

  egress {
    //allow all
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "nia_gp2gp_db_sg"
  }

}

## ELB Module ##
// All the below can be put in to a tf module setting up load balancing
// outputs:
// - IP address
// - target group id

resource "aws_lb_target_group" "nia_gp2gp_target_group" {
  type  = ip
  
}

resource "aws_lb" "nia_gp2gp_elb" {
  name            = "nia-gp2gp-elb"
  subnets         = [for subnet in aws_subnet.nia_gp2gp_public_subnet : subnet.id]
  load_balancer_type = "network"

  tags = {
    Name = "nia_gp2gp-elb"
  }
}

resource "aws_lb_listener" "inbound" {
    load_balancer_arn = aws_lb.nia_gp2gp_elb.arn
    port           = var.http_server_port
    protocol       = "TCP"
    default_action {
      type             = "forward"
      target_group_arn = aws_lb_target_group.nia_gp2gp_target_group.arn
    }
}

## ECS Module ##

resource "aws_ecs_cluster" "nia_gp2gp_cluster" {
  name = "gp2gp-ps-chain"
}

resource "aws_ssm_parameter" "AWS_ACCESS_KEY_ID" {
  name        = "/gp2gp_ps_daisychain/AWS_ACCESS_KEY_ID"
  type        = "SecureString"
  value       = var.AWS_ACCESS_KEY_ID
}

resource "aws_ssm_parameter" "AWS_SECRET_ACCESS_KEY" {
  name        = "/gp2gp_ps_daisychain/AWS_SECRET_ACCESS_KEY"
  type        = "SecureString"
  value       = var.AWS_SECRET_ACCESS_KEY
}

resource "aws_ssm_parameter" "AZURE_STORAGE_CONNECTION_STRING" {
  name        = "/gp2gp_ps_daisychain/AZURE_STORAGE_CONNECTION_STRING"
  type        = "SecureString"
  value       = var.AZURE_STORAGE_CONNECTION_STRING
}

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
  value       = var.MHS_SECRET_CA_CERTS
}
resource "aws_ssm_parameter" "MHS_SECRET_CLIENT_CERT" {
  name        = "/gp2gp_ps_daisychain/MHS_SECRET_CLIENT_CERT"
  type        = "SecureString"
  value       = var.MHS_SECRET_CLIENT_CERT
}
resource "aws_ssm_parameter" "MHS_SECRET_CLIENT_KEY" {
  name        = "/gp2gp_ps_daisychain/MHS_SECRET_CLIENT_KEY"
  type        = "SecureString"
  value       = var.MHS_SECRET_CLIENT_KEY
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

resource "aws_iam_role" "ecs_task_execution_role" {
  name = "gp2gp_ps_ecs_execution"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ecs.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy" "ecs_task_execution_role_policy" {
  name = "gp2gp_ps_ecs_execution_policy"
  role = aws_iam_role.ecs_task_execution_role.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ssm:GetParametersByPath",
          "ssm:GetParameters",
          "ssm:GetParameter"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })  
}

resource "aws_ecs_cluster" "gp2gp_ps" {
  name = "gp2gp_ps"
}

resource "aws_ecs_task_definition" "gp2gp_ps_task" {
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.cpu
  memory                   = var.memory
  network_mode             = "awsvpc"
  container_definitions    = data.template_file.gp2gp_ps_task_template.rendered
  family                   = "gp2gp_ps"
}

resource "aws_ecs_service" "gp2gp_ps" {
  name            = "gp2gp_ps"
  cluster         = aws_ecs_cluster.gp2gp_ps.arn
  task_definition = aws_ecs_task_definition.gp2gp_ps_task.arn
  desired_count   = 1
  iam_role        = aws_iam_role.ecs_task_execution_role.arn
  depends_on      = [aws_iam_role.ecs_task_execution_role]

  load_balancer {
    target_group_arn = aws_lb_target_group.nia_gp2gp_target_group.arn
    container_name   = "gp2gp"
    container_port   = var.GP2GP_SERVER_PORT
  }
}
