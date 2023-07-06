provider "aws" {
  region  = "eu-west-2"
}

data "aws_availability_zones" "available" {
  state = "available"
}

data "template_file" "gp2gp_ps_task_template" {
  template = templatefile("../ecs_tasks/gp2gp_ps.tpl.json" , {

## Secrets ##
// Load these from param store

#    AZURE_STORAGE_CONNECTION_STRING = aws_ssm_parameter.AZURE_STORAGE_CONNECTION_STRING.arn
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
#    GP2GP_GPC_DOCUMENTS_FHIR_BASE = var.GP2GP_GPC_DOCUMENTS_FHIR_BASE
#    GP2GP_GPC_GET_TEST_URL = var.GP2GP_GPC_GET_TEST_URL
    GP2GP_GPC_GET_URL = var.GP2GP_GPC_GET_URL
#    GP2GP_GPC_OVERRIDE_FROM_ASID = var.GP2GP_GPC_OVERRIDE_FROM_ASID
##    GP2GP_GPC_OVERRIDE_NHS_NUMBER = var.GP2GP_GPC_OVERRIDE_NHS_NUMBER
#    GP2GP_GPC_OVERRIDE_TO_ASID = var.GP2GP_GPC_OVERRIDE_TO_ASID
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
#    GP2GP_SSL_TRUST_STORE_URL = var.GP2GP_SSL_TRUST_STORE_URL
    GP2GP_STORAGE_CONTAINER_NAME = var.GP2GP_STORAGE_CONTAINER_NAME
    GP2GP_STORAGE_TYPE = var.GP2GP_STORAGE_TYPE
    GP2GP_TRANSLATOR_SERVER_PORT = var.GP2GP_TRANSLATOR_SERVER_PORT
#    GPC_CONSUMER_GPC_GET_DOCUMENT_PATH = var.GPC_CONSUMER_GPC_GET_DOCUMENT_PATH
#    GPC_CONSUMER_GPC_GET_PATIENT_PATH = var.GPC_CONSUMER_GPC_GET_PATIENT_PATH
#    GPC_CONSUMER_GPC_STRUCTURED_PATH = var.GPC_CONSUMER_GPC_STRUCTURED_PATH
    GPC_CONSUMER_LOGGING_LEVEL = var.GPC_CONSUMER_LOGGING_LEVEL
    GPC_CONSUMER_SDS_APIKEY = var.GPC_CONSUMER_SDS_APIKEY
    GPC_CONSUMER_SDS_URL = var.GPC_CONSUMER_SDS_URL
#    GPC_CONSUMER_SEARCH_DOCUMENTS_PATH = var.GPC_CONSUMER_SEARCH_DOCUMENTS_PATH
    GPC_CONSUMER_SERVER_PORT = var.GPC_CONSUMER_SERVER_PORT
#    GPC_CONSUMER_SPINE_CLIENT_CERT = var.GPC_CONSUMER_SPINE_CLIENT_CERT
#    GPC_CONSUMER_SPINE_CLIENT_KEY = var.GPC_CONSUMER_SPINE_CLIENT_KEY
#    GPC_CONSUMER_SPINE_ROOT_CA_CERT = var.GPC_CONSUMER_SPINE_ROOT_CA_CERT
#    GPC_CONSUMER_SPINE_SUB_CA_CERT = var.GPC_CONSUMER_SPINE_SUB_CA_CERT
#    GPC_CONSUMER_SSP_URL = var.GPC_CONSUMER_SSP_URL
    GPC_FACADE_SERVER_PORT = var.FACADE_SERVER_PORT
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
    MHS_STATE_TABLE_NAME = aws_dynamodb_table.mhs_state_table.name
    MHS_SYNC_ASYNC_STATE_TABLE_NAME = aws_dynamodb_table.mhs_sync_async_table.name
    PS_AMQP_BROKER = var.PS_AMQP_BROKER
    PS_AMQP_MAX_REDELIVERIES = var.PS_AMQP_MAX_REDELIVERIES
    PS_DAISY_CHAINING_ACTIVE = var.PS_DAISY_CHAINING_ACTIVE
    PS_DB_URL = local.ps_db_instance_url
    PS_LOGGING_LEVEL = var.PS_LOGGING_LEVEL
    GP2GP_LOGGING_LEVEL = var.GP2GP_LOGGING_LEVEL
    PS_QUEUE_NAME = var.PS_QUEUE_NAME
    SERVICE_PORTS = var.MHS_INBOUND_SERVICE_PORTS
    STORAGE_CONTAINER_NAME = var.STORAGE_CONTAINER_NAME
    STORAGE_REFERENCE = var.STORAGE_REFERENCE
    STORAGE_REGION = var.STORAGE_REGION
    STORAGE_TYPE = var.STORAGE_TYPE
    SUPPORTED_FILE_TYPES = var.SUPPORTED_FILE_TYPES
    TCP_PORTS = var.MHS_INBOUND_PORT
    MHS_INBOUND_VERSION = var.MHS_INBOUND_VERSION
    MHS_OUTBOUND_VERSION = var.MHS_OUTBOUND_VERSION
    PS_TRANSLATOR_VERSION = var.PS_TRANSLATOR_VERSION
    PS_FACADE_VERSION = var.PS_FACADE_VERSION
    PS_DB_MIGRATION_VERSION = var.PS_DB_MIGRATION_VERSION
    GP2GP_ADAPTOR_VERSION = var.GP2GP_ADAPTOR_VERSION
    GPCC_ADAPTOR_VERSION = var.GPCC_ADAPTOR_VERSION
    MONGODB_VERSION = var.MONGODB_VERSION
    MHS_INBOUND_PORT = var.MHS_INBOUND_PORT
    MHS_OUTBOUND_PORT = var.MHS_OUTBOUND_PORT
    MHS_INBOUND_SERVICE_PORTS = var.MHS_INBOUND_SERVICE_PORTS
    PS_DB_PORT = var.PS_DB_PORT
    AWS_MQ_BROKER = replace(aws_mq_broker.gp2gp_ps_broker.instances.0.endpoints.1, "amqp+ssl", "amqps")
    AWS_PS_DB_ENDPOINT = "jdbc:postgresql://${aws_db_instance.ps_db.endpoint}"
#    AWS_PS_DB_PASSWORD_SECRET = aws_db_instance.ps_db.master_user_secret.0.secret_arn
    MOCK_SPINE_VERSION = var.MOCK_SPINE_VERSION
    WIREMOCK_VERSION = var.WIREMOCK_VERSION
    WIREMOCK_PORT = var.WIREMOCK_PORT
  }
    )
}

data "template_file" "ps_db_migration" {
  template = templatefile("../ecs_tasks/ps_db_migration.tpl.json" , {
    AWS_PS_DB_ENDPOINT = "jdbc:postgresql://${aws_db_instance.ps_db.endpoint}"
#    AWS_PS_DB_PASSWORD_SECRET = aws_db_instance.ps_db.master_user_secret.0.secret_arn
    POSTGRES_PASSWORD = aws_ssm_parameter.POSTGRES_PASSWORD.arn
    PS_DB_OWNER_NAME = aws_ssm_parameter.PS_DB_OWNER_NAME.arn
    GPC_FACADE_USER_DB_PASSWORD = aws_ssm_parameter.GPC_FACADE_USER_DB_PASSWORD.arn
    GP2GP_TRANSLATOR_USER_DB_PASSWORD = aws_ssm_parameter.GP2GP_TRANSLATOR_USER_DB_PASSWORD.arn
    PS_DB_MIGRATION_VERSION = var.PS_DB_MIGRATION_VERSION
  } )
}

resource "aws_ecs_cluster" "gp2gp_ps" {
  name = "gp2gp_ps"
}

resource "aws_ecs_task_definition" "gp2gp_ps_task" {
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn            = aws_iam_role.adaptor_execution.arn
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.cpu
  memory                   = var.memory
  network_mode             = "awsvpc"
  container_definitions    = data.template_file.gp2gp_ps_task_template.rendered
  family                   = "gp2gp_ps"
}

resource "aws_ecs_task_definition" "gp2gp_ps_db_migration" {
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.cpu
  memory                   = var.memory
  network_mode             = "awsvpc"
  container_definitions    = data.template_file.ps_db_migration.rendered
  family                   = "ps_db_migration"
}

resource "aws_ecs_service" "gp2gp_ps" {
  name            = "gp2gp_ps"
  cluster         = aws_ecs_cluster.gp2gp_ps.arn
  task_definition = aws_ecs_task_definition.gp2gp_ps_task.arn
  desired_count   = 1
  depends_on      = [aws_lb_listener.mhs_inbound, aws_iam_role.ecs_task_execution_role, aws_db_instance.ps_db]
  launch_type     = "FARGATE"


  network_configuration {
    subnets = [for subnet in aws_subnet.nia_gp2gp_public_subnet : subnet.id]
    assign_public_ip = true
    security_groups = [aws_security_group.nia_gp2gp_dmz.id]
  }

  #Not sure if set up correctly - currently only using for a Health Check (should probably be using Inbound)
  load_balancer {
    target_group_arn = aws_lb_target_group.nia_gp2gp_target_group_facade.arn
    container_name   = "gpc_facade"
    container_port   = var.FACADE_SERVER_PORT
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.nia_gp2gp_target_group_inbound.arn
    container_name   = "inbound"
    container_port   = var.MHS_INBOUND_PORT
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.nia_gp2gp_target_group_spine.arn
    container_name   = "mock-spine"
    container_port   = var.MOCK_SPINE_PORT
  }
}

resource "aws_ecs_service" "ps_db_migration" {
  name            = "ps_db_migration"
  cluster         = aws_ecs_cluster.gp2gp_ps.arn
  task_definition = aws_ecs_task_definition.gp2gp_ps_db_migration.arn
  desired_count   = 1
  depends_on      = [aws_iam_role.ecs_task_execution_role, aws_db_instance.ps_db]
  launch_type     = "FARGATE"

  network_configuration {
    subnets = [for subnet in aws_subnet.nia_gp2gp_public_subnet : subnet.id]
    assign_public_ip = "true"
    security_groups = [aws_security_group.ps_db_sg.id]
  }
}


