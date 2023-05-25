## Application Secrets ##
// we might want to handle these differently in tf

variable "AZURE_STORAGE_CONNECTION_STRING" {
        type=string
        sensitive=true
}
variable "GP2GP_AMQP_PASSWORD" {
        type=string
        sensitive=true
}
variable "GP2GP_AMQP_USERNAME" {
        type=string
        sensitive=true
}
variable "GP2GP_SSL_TRUST_STORE_PASSWORD" {
        type=string
        sensitive=true
}
variable "GP2GP_TRANSLATOR_USER_DB_PASSWORD" {
        type=string
        sensitive=true
}
variable "GPC_FACADE_USER_DB_PASSWORD" {
        type=string
        sensitive=true
}
variable "MHS_AMQP_PASSWORD" {
        type=string
        sensitive=true
}
variable "MHS_AMQP_USERNAME" {
        type=string
        sensitive=true
}
variable "MHS_SECRET_CA_CERTS" {
        type=string
        sensitive=true
}
variable "MHS_SECRET_CLIENT_CERT" {
        type=string
        sensitive=true
}
variable "MHS_SECRET_CLIENT_KEY" {
        type=string
        sensitive=true
}
variable "MHS_SECRET_INBOUND_QUEUE_PASSWORD" {
        type=string
        sensitive=true
}
variable "MHS_SECRET_INBOUND_QUEUE_USERNAME" {
        type=string
        sensitive=true
}
variable "MHS_SECRET_PARTY_KEY" {
        type=string
        sensitive=true
}
variable "POSTGRES_PASSWORD" {
        type=string
        sensitive=true
}
variable "PS_AMQP_PASSWORD" {
        type=string
        sensitive=true
}
variable "PS_AMQP_USERNAME" {
        type=string
        sensitive=true
}
variable "PS_DB_OWNER_NAME" {
        type=string
        sensitive=true
}
variable "STORAGE_SECRET" {
        type=string
        sensitive=true
}

## Application Environment Variables ##

variable "AWS_REGION" {
        type=string
        default = null
}
variable "GP2GP_AMQP_BROKERS" {
        type=string
}
variable "GP2GP_AMQP_MAX_REDELIVERIES" {
        type=string
}
variable "GP2GP_COSMOS_DB_ENABLED" {
        type=string
}
variable "GP2GP_GPC_DOCUMENTS_FHIR_BASE" {
        type=string
}
variable "GP2GP_GPC_GET_TEST_URL" {
        type=string
}
variable "GP2GP_GPC_GET_URL" {
        type=string
}
variable "GP2GP_GPC_OVERRIDE_FROM_ASID" {
        type=string
}
variable "GP2GP_GPC_OVERRIDE_NHS_NUMBER" {
        type=string
}
variable "GP2GP_GPC_OVERRIDE_TO_ASID" {
        type=string
}
variable "GP2GP_GPC_STRUCTURED_FHIR_BASE" {
        type=string
}
variable "GP2GP_LARGE_ATTACHMENT_THRESHOLD" {
        type=string
}
variable "GP2GP_LARGE_EHR_EXTRACT_THRESHOLD" {
        type=string
}
variable "GP2GP_LOGGING_LEVEL" {
        type=string
}
variable "GP2GP_MHS_INBOUND_QUEUE" {
        type=string
}
variable "GP2GP_MHS_OUTBOUND_URL" {
        type=string
}
variable "GP2GP_MONGO_DATABASE_NAME" {
        type=string
}
variable "GP2GP_MONGO_TTL" {
        type=string
}
variable "GP2GP_MONGO_URI" {
        type=string
}
variable "GP2GP_SERVER_PORT" {
        type=string
}
variable "GP2GP_SSL_TRUST_STORE_URL" {
        type=string
}
variable "GP2GP_STORAGE_CONTAINER_NAME" {
        type=string
        default = null
}
variable "GP2GP_STORAGE_TYPE" {
        type=string
        default = null
}
variable "GP2GP_TRANSLATOR_SERVER_PORT" {
        type=string
}
variable "GPC_CONSUMER_GPC_GET_DOCUMENT_PATH" {
        type=string
}
variable "GPC_CONSUMER_GPC_GET_PATIENT_PATH" {
        type=string
}
variable "GPC_CONSUMER_GPC_STRUCTURED_PATH" {
        type=string
}
variable "GPC_CONSUMER_LOGGING_LEVEL" {
        type=string
}
variable "GPC_CONSUMER_SDS_APIKEY" {
        type=string
}
variable "GPC_CONSUMER_SDS_URL" {
        type=string
}
variable "GPC_CONSUMER_SEARCH_DOCUMENTS_PATH" {
        type=string
}
variable "GPC_CONSUMER_SERVER_PORT" {
        type=string
}
variable "GPC_CONSUMER_SPINE_CLIENT_CERT" {
        type=string
        default = null
}
variable "GPC_CONSUMER_SPINE_CLIENT_KEY" {
        type=string
        default = null
}
variable "GPC_CONSUMER_SPINE_ROOT_CA_CERT" {
        type=string
        default = null
}
variable "GPC_CONSUMER_SPINE_SUB_CA_CERT" {
        type=string  
        default = null
}
variable "GPC_CONSUMER_SSP_URL" {
        type=string
        default = null
}
variable "GPC_FACADE_SERVER_PORT" {
        type=string
}
variable "MAX_RESYNC_RETRIES" {
        type=string
}
variable "MHS_AMQP_BROKER" {
        type=string
}
variable "MHS_AMQP_MAX_REDELIVERIES" {
        type=string
}
variable "MHS_BASE_URL" {
        type=string
}
variable "MHS_DB_ENDPOINT_URL" {
        type=string
}
variable "MHS_FORWARD_RELIABLE_ENDPOINT_URL" {
        type=string
}
variable "MHS_INBOUND_HEALTHCHECK_SERVER_PORT" {
        type=string
}
variable "MHS_INBOUND_PORT" {
        type=string
}
variable "MHS_INBOUND_QUEUE_MESSAGE_TTL_IN_SECONDS" {
        type=string
}
variable "MHS_INBOUND_SERVICE_PORTS" {
        type=string
}
variable "MHS_INBOUND_USE_SSL" {
        type=string
}
variable "MHS_LOG_LEVEL" {
        type=string
}
variable "MHS_OUTBOUND_ROUTING_LOOKUP_METHOD" {
        type=string
}
variable "MHS_OUTBOUND_VALIDATE_CERTIFICATE" {
        type=string
}
variable "MHS_QUEUE_NAME" {
        type=string
}
variable "MHS_RESYNC_INTERVAL" {
        type=string
}
variable "MHS_SDS_API_KEY" {
        type=string
}
variable "MHS_SDS_API_URL" {
        type=string
}
variable "MHS_SPINE_ORG_CODE" {
        type=string
}
variable "MHS_SPINE_REQUEST_MAX_SIZE" {
        type=string
}
variable "MHS_SPINE_ROUTE_LOOKUP_URL" {
        type=string
}
variable "MHS_STATE_TABLE_NAME" {
        type=string
}
variable "MHS_SYNC_ASYNC_STATE_TABLE_NAME" {
        type=string
}
variable "PS_AMQP_BROKER" {
        type=string
}
variable "PS_AMQP_MAX_REDELIVERIES" {
        type=string
}
variable "PS_DAISY_CHAINING_ACTIVE" {
        type=string
}
variable "PS_DB_URL" {
        type=string
}
variable "PS_LOGGING_LEVEL" {
        type=string
}
variable "PS_QUEUE_NAME" {
        type=string
}
variable "SERVICE_PORTS" {
        type=string
}
variable "STORAGE_CONTAINER_NAME" {
        type=string
}
variable "STORAGE_REFERENCE" {
        type=string
}
variable "STORAGE_REGION" {
        type=string
}
variable "STORAGE_TYPE" {
        type=string
}
variable "SUPPORTED_FILE_TYPES" {
        type=string
}

## Infrastrcuture Environment ##

variable "cpu" {
        type = number
        default = 1
}

variable "http_server_port" {
        type = number
        default = 80
}

variable "memory" {
        type = string
        default = "256mb"
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
        type = number
        default = 21
}

variable "subnet_count" {
  description = "Number of subnets"
  type        = map(number)
  default = {
    public  = 1,
    private = 2
  }
}

variable "vpc_cidr_block" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "MOCK_SPINE_VERSION" {
        type = string
        default = null
}