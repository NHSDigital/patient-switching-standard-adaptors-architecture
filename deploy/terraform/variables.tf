## Application Secrets ##
// we might want to handle these differently in tf

#variable "AZURE_STORAGE_CONNECTION_STRING" {
#        type=string
#        sensitive=true
#}

locals {
  ps_db_instance_url = "jdbc:postgresql://${aws_db_instance.ps_db.endpoint}"
}

variable "GP2GP_AMQP_PASSWORD" {
  type      = string
  sensitive = true
}

variable "GP2GP_AMQP_USERNAME" {
  type      = string
  sensitive = true
}

variable "GP2GP_SSL_TRUST_STORE_PASSWORD" {
  type      = string
  sensitive = true
  default   = null
}

variable "GP2GP_TRANSLATOR_USER_DB_PASSWORD" {
  type      = string
  sensitive = true
}

variable "GPC_FACADE_USER_DB_PASSWORD" {
  type      = string
  sensitive = true
  default   = null
}

variable "MHS_AMQP_PASSWORD" {
  type      = string
  sensitive = true
}

variable "MHS_AMQP_USERNAME" {
  type      = string
  sensitive = true
}

variable "MHS_SECRET_CA_CERTS" {
  type      = string
  sensitive = true
}

variable "MHS_SECRET_CLIENT_CERT" {
  type      = string
  sensitive = true
}

variable "MHS_SECRET_CLIENT_KEY" {
  type      = string
  sensitive = true
}

variable "MHS_SECRET_INBOUND_QUEUE_PASSWORD" {
  type      = string
  sensitive = true
}

variable "MHS_SECRET_INBOUND_QUEUE_USERNAME" {
  type      = string
  sensitive = true
}

variable "MHS_SECRET_PARTY_KEY" {
  type      = string
  sensitive = true
}

variable "PS_AMQP_PASSWORD" {
  type      = string
  sensitive = true
}

variable "PS_AMQP_USERNAME" {
  type      = string
  sensitive = true
}

variable "PS_DB_OWNER_NAME" {
  type      = string
  sensitive = true
}

variable "STORAGE_SECRET" {
  type      = string
  sensitive = true
}

variable "POSTGRES_PASSWORD" {
  type      = string
  sensitive = true
}

## Application Environment Variables ##

variable "AWS_REGION" {
  type    = string
  default = "eu-west-2"
}

variable "GP2GP_AMQP_BROKERS" {
  type    = string
  default = null
}

variable "GP2GP_AMQP_MAX_REDELIVERIES" {
  type    = string
  default = "3"
}

variable "GP2GP_COSMOS_DB_ENABLED" {
  type    = bool
  default = false
}

variable "GP2GP_GPC_DOCUMENTS_FHIR_BASE" {
  type    = string
  default = null
}

variable "GP2GP_GPC_GET_TEST_URL" {
  type    = string
  default = null
}

variable "GP2GP_GPC_GET_URL" {
  type    = string
  default = "http://localhost:8090/@ODS_CODE@/STU3/1/gpconnect"
}

variable "GP2GP_GPC_OVERRIDE_FROM_ASID" {
  type    = string
  default = null
}

variable "GP2GP_GPC_OVERRIDE_NHS_NUMBER" {
  type    = string
  default = null
}

variable "GP2GP_GPC_OVERRIDE_TO_ASID" {
  type    = string
  default = null
}

variable "GP2GP_GPC_STRUCTURED_FHIR_BASE" {
  type    = string
  default = null
}

variable "GP2GP_LARGE_ATTACHMENT_THRESHOLD" {
  type    = string
  default = "31216"
}

variable "GP2GP_LARGE_EHR_EXTRACT_THRESHOLD" {
  type    = string
  default = "31216"
}

variable "GP2GP_LOGGING_LEVEL" {
  type    = string
  default = null
}

variable "GP2GP_MHS_INBOUND_QUEUE" {
  type    = string
  default = "gp2gpInboundQueue"
}

variable "GP2GP_MHS_OUTBOUND_URL" {
  type    = string
  default = "http://localhost:80"
}

variable "GP2GP_MONGO_DATABASE_NAME" {
  type    = string
  default = "gp2gp"
}

variable "GP2GP_MONGO_TTL" {
  type    = string
  default = null
}

variable "GP2GP_MONGO_URI" {
  type    = string
  default = "mongodb://localhost:27017"
}

variable "GP2GP_SERVER_PORT" {
  type    = number
  default = 8183
}

variable "GP2GP_SSL_TRUST_STORE_URL" {
  type    = string
  default = null
}

variable "GP2GP_STORAGE_CONTAINER_NAME" {
  type    = string
  default = "gp2gp-storage-bucket"
}

variable "GP2GP_STORAGE_TYPE" {
  type    = string
  default = "S3"
}

variable "GP2GP_TRANSLATOR_SERVER_PORT" {
  type    = number
  default = 8085
}

variable "GPC_CONSUMER_GPC_GET_DOCUMENT_PATH" {
  type    = string
  default = null
}

variable "GPC_CONSUMER_GPC_GET_PATIENT_PATH" {
  type    = string
  default = null
}

variable "GPC_CONSUMER_GPC_STRUCTURED_PATH" {
  type    = string
  default = null
}

variable "GPC_CONSUMER_LOGGING_LEVEL" {
  type    = string
  default = null
}

variable "GPC_CONSUMER_SDS_APIKEY" {
  type    = string
  default = "anykey"
}

variable "GPC_CONSUMER_SDS_URL" {
  type    = string
  default = "http://localhost:8080/spine-directory/"
}

variable "GPC_CONSUMER_SEARCH_DOCUMENTS_PATH" {
  type    = string
  default = null
}

variable "GPC_CONSUMER_SERVER_PORT" {
  type    = number
  default = 8090
}

variable "GPC_CONSUMER_SPINE_CLIENT_CERT" {
  type    = string
  default = null
}

variable "GPC_CONSUMER_SPINE_CLIENT_KEY" {
  type    = string
  default = null
}

variable "GPC_CONSUMER_SPINE_ROOT_CA_CERT" {
  type    = string
  default = null
}

variable "GPC_CONSUMER_SPINE_SUB_CA_CERT" {
  type    = string
  default = null
}

variable "GPC_CONSUMER_SSP_URL" {
  type    = string
  default = null
}

variable "FACADE_SERVER_PORT" {
  type    = number
  default = 8081
}

variable "WIREMOCK_PORT" {
  type    = number
  default = 8080
}

variable "MAX_RESYNC_RETRIES" {
  type    = string
  default = "20"
}

variable "MHS_AMQP_BROKER" {
  type = string
}

variable "MHS_AMQP_MAX_REDELIVERIES" {
  type    = string
  default = "3"
}

variable "MHS_BASE_URL" {
  type    = string
  default = "http://localhost:80/"
}

variable "MHS_DB_ENDPOINT_URL" {
  type    = string
  default = null
}

variable "MHS_FORWARD_RELIABLE_ENDPOINT_URL" {
  type    = string
  default = "https://localhost:8443/reliablemessaging/forwardreliable"
}

variable "MHS_INBOUND_HEALTHCHECK_SERVER_PORT" {
  type    = number
  default = 8083
}

variable "MHS_INBOUND_PORT" {
  type    = number
  default = 443
}

variable "MHS_INBOUND_PORT_2" {
  type    = number
  default = 8084
}

variable "MOCK_SPINE_PORT" {
  type    = number
  default = 8086
}

variable "MQ_PORT" {
  type = number
  default = 5671
}

variable "MHS_INBOUND_QUEUE_MESSAGE_TTL_IN_SECONDS" {
  type    = string
  default = "1000"
}

variable "MHS_INBOUND_SERVICE_PORTS" {
  type    = string
  default = "443,8084"
}

variable "MHS_INBOUND_USE_SSL" {
  type    = string
  default = "True"
}

variable "MHS_LOG_LEVEL" {
  type    = string
  default = "DEBUG"
}

variable "MHS_OUTBOUND_ROUTING_LOOKUP_METHOD" {
  type    = string
  default = "SPINE_ROUTE_LOOKUP"
}

variable "MHS_OUTBOUND_VALIDATE_CERTIFICATE" {
  type    = string
  default = "False"
}

variable "MHS_QUEUE_NAME" {
  type    = string
  default = "mhsQueue"
}

variable "MHS_RESYNC_INTERVAL" {
  type    = string
  default = "1"
}

variable "MHS_SDS_API_KEY" {
  type    = string
  default = "Nn8Y3sofb3B2PuhFA7EOzr8wQguoMTMG"
}

variable "MHS_SDS_API_URL" {
  type    = string
  default = "https://int.api.service.nhs.uk/spine-directory/FHIR/R4/"
}

variable "MHS_SPINE_ORG_CODE" {
  type    = string
  default = "YES"
}

variable "MHS_SPINE_REQUEST_MAX_SIZE" {
  type    = string
  default = "4999600"
}

variable "MHS_SPINE_ROUTE_LOOKUP_URL" {
  type    = string
  default = "http://localhost:8086"
}

variable "MHS_STATE_TABLE_NAME" {
  type    = string
  default = "mhs_state"
}

variable "MHS_SYNC_ASYNC_STATE_TABLE_NAME" {
  type    = string
  default = "sync_async_state"
}

variable "PS_AMQP_BROKER" {
  type    = string
  default = null
}

variable "PS_AMQP_MAX_REDELIVERIES" {
  type    = string
  default = "3"
}

variable "PS_DAISY_CHAINING_ACTIVE" {
  type    = string
  default = "true"
}

variable "PS_DB_URL" {
  type    = string
  default = "jdbc:postgresql://localhost:5436"
}

variable "PS_LOGGING_LEVEL" {
  type    = string
  default = "DEBUG"
}

variable "PS_QUEUE_NAME" {
  type    = string
  default = "pssQueue"
}

variable "SERVICE_PORTS" {
  type    = string
  default = "443,8084"
}

variable "STORAGE_CONTAINER_NAME" {
  type    = string
  default = "ps-storage-bucket"
}

variable "STORAGE_REFERENCE" {
  type    = string
  default = "arn:aws:kms:eu-west-2:067756640211:key/a7c4a919-0042-4dd3-bdda-d08632d2475e"
}

variable "STORAGE_REGION" {
  type    = string
  default = "eu-west-2"
}

variable "STORAGE_TYPE" {
  type    = string
  default = "LocalMock"
}

variable "SUPPORTED_FILE_TYPES" {
  type    = string
  default = "application/msword,application/vnd.openxmlformats-officedocument.wordprocessingml.document,application/msoutlook,text/rtf,text/plain,image/bmp,image/gif,image/jpeg,image/png,image/tiff,application/xml,audio/x-aiff,audio/x-mpegurl,audio/mpeg,audio/x-wav,audio/x-ms-wma,video/3gpp2,video/3gpp,video/x-ms-asf,video/x-ms-asf,video/x-msvideo,video/x-flv,video/quicktime,video/mp4,video/mpeg,audio/vnd.rn-realaudio,application/x-shockwave-flash,video/x-ms-vob,video/x-ms-wmv,application/postscript,application/postscript,image/svg+xml,image/x-pict,application/pdf,application/vnd.openxmlformats-package.relationships+xml,text/css,text/html,application/xhtml+xml,text/plain,application/json,text/xml,application/xml,application/pdf,audio/basic,audio/mpeg,image/png,image/gif,image/jpeg,image/tiff,video/mpeg,application/msword,application/octet-stream,text/csv,application/dicom,application/zip,application/x-rar-compressed,application/x-gzip,application/vnd.ms-excel,application/vnd.openxmlformats-officedocument.spreadsheetml.sheet,application/x-mplayer2,audio/x-au,application/x-troff-msvideo,video/msvideo,image/x-windows-bmp,application/pkix-cert,application/x-x509-ca-cert,application/cdf,application/x-cdf,application/x-netcdf,application/x-x509-user-cert,application/EDIFACT,application/EDI-X12,application/EDI-Consent,application/hl7-v2,application/hl7-v2+xml,video/x-mpeg,application/pkcs10,application/x-pkcs10,application/pkcs-12,application/x-pkcs12,application/x-pkcs7-signature,application/pkcs7-mime,application/x-pkcs7-mime,application/pkcs7-mime,application/x-pkcs7-mime,application/x-pkcs7-certreqresp,application/pkcs7-signature,application/x-rtf,application/x-compressed,application/x-zip-compressed,multipart/x-zip,application/pgp,application/pgp-keys,application/pgp-signature,application/x-pgp-plugin,application/pgp-encrypted,audio/wav,audio/wave,audio/x-pn-wav,chemical/x-mdl-sdfile,chemical/x-mdl-molfile,chemical/x-pdb,application/x-hl7"
}

## Infrastructure Environment ##

variable "cpu" {
  type    = number
  default = 2048
}

variable "http_server_port" {
  type    = number
  default = 80
}

variable "memory" {
  type    = number
  default = 8192
}

variable "ecs_launch_type_fargate" {
  description = "Fargate launch type for ECS"
  type = string
  default = "FARGATE"
}

variable "ecs_task_network_mode_aws_vpc" {
  description = "Network mode of AWS VPC for ECS Task"
  type = string
  default = "awsvpc"
}

variable "public_subnet_cidr_blocks" {
  description = "Available CIDR blocks for public subnets"
  type        = list(string)
  default = [
    "10.0.1.0/24",
    "10.0.2.0/24",
    "10.0.3.0/24",
    "10.0.4.0/24",
  ]
}

variable "private_subnet_cidr_blocks" {
  description = "Available CIDR blocks for private subnets"
  type        = list(string)
  default = [
    "10.0.101.0/24",
    "10.0.102.0/24",
    "10.0.103.0/24",
    "10.0.104.0/24",
  ]
}

variable "ssh_server_port" {
  type    = number
  default = 21
}

variable "subnet_count" {
  description = "Number of subnets"
  type        = map(number)
  default = {
    public  = 2,
    private = 2
  }
}

variable "vpc_cidr_block" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "allow_all_cidr_block" {
  description = "CIDR block to allow all IP addresses"
  type = string
  default = "0.0.0.0/0"
}

variable "allow_all_ipv6_cidr_block" {
  description = "IPV6 CIDR block to allow all IP addresses"
  type = string
  default = "::/0"
}

variable "vpc_protocol_default" {
  description = "default protocol for VPC"
  type = string
  default = "TCP"
}

variable "allow_all_vpc_protocol" {
  description = "Allow all protocol for VPC"
  type = string
  default = "-1"
}

variable "allow_all_vpc_port" {
  description = "Allow all port for VPC"
  type = number
  default = 0
}

variable "mq_engine_type" {
  description = "Message queue engine type"
  type = string
  default = "ActiveMQ"
}

variable "mq_engine_version" {
  description = "Message queue engine version"
  type = string
  default = "5.16.3"
}

variable "mq_host_type" {
  description = "Message queue host instance type"
  type = string
  default = "mq.t2.micro"
}

variable "dynamodb_table_hash_key" {
  description = "Attribute to use as the dynamodb hash key"
  type = string
  default = "key"
}

variable "dynamodb_attribute_type_string" {
  description = "Attribute type of string for dynamodb table"
  type = string
  default = "S"
}

variable "dynamodb_table_billing_mode" {
  description = "Billing mode for the dynamodb table"
  type = string
  default = "PAY_PER_REQUEST"
}

variable "lb_health_check_matcher_port_range" {
  description = "Response codes to use when checking for a healthy responses from health check"
  type = string
  default = "200-499"
}

variable "lb_health_check_poll_interval" {
  description = "Approximate amount of time, in seconds, between health checks"
  type = number
  default = 300
}

variable "iam_policy_version" {
  description = "Version for IAM policies"
  type = string
  default = "2012-10-17"
}

variable "iam_statement_assume_role" {
  description = "Policy statement with the defaults for assume role"
  type = list(object({
    Action = string
    Effect = string
    Sid = string
    Principal = object({
      Service = string
    })
  }))
  default = [
    {
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Sid    = ""
      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      }
    }
  ]
}

variable "iam_role_policy_effect_allow" {
  description = "IAM role policy effect for allow"
  type = string
  default = "Allow"
}

variable "iam_role_policy_resource_all" {
  description = "IWM role policy resource for all"
  type = string
  default = "*"
}

variable "lb_target_type_ip" {
  description = "Specify IP type when registering targets with this target group"
  type = string
  default = "ip"
}

variable "lb_listener_default_action_type" {
  description =  "Type of routing action"
  type = string
  default = "forward"
}

variable "cloudwatch_log_stream_name" {
  type = string
  default = "ps-daisychain"
}

variable "MHS_INBOUND_VERSION" {
  type    = string
  default = null
}

variable "MHS_OUTBOUND_VERSION" {
  type    = string
  default = null
}

variable "MHS_OUTBOUND_PORT" {
  type    = string
  default = null
}

variable "PS_FACADE_VERSION" {
  type    = string
  default = null
}

variable "PS_TRANSLATOR_VERSION" {
  type    = string
  default = null
}

variable "PS_DB_PORT" {
  type    = number
  default = 5432
}

variable "PS_DB_MIGRATION_VERSION" {
  type    = string
  default = null
}

variable "GP2GP_ADAPTOR_VERSION" {
  type    = string
  default = null
}

variable "GPCC_ADAPTOR_VERSION" {
  type    = string
  default = null
}

variable "ACTIVEMQ_VERSION" {
  type    = string
  default = null
}

variable "DYNAMODB_VERSION" {
  type    = string
  default = null
}

variable "MONGODB_VERSION" {
  type    = string
  default = null
}

variable "MOCK_SPINE_VERSION" {
  type    = string
  default = null
}
variable "WIREMOCK_VERSION" {
  type    = string
  default = null
}

variable "MQ_USERNAME" {
  type    = string
  default = null
}

variable "MQ_PASSWORD" {
  type    = string
  default = null
}



