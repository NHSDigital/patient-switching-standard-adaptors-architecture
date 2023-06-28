## Application Secrets ##
// we might want to handle these differently in tf

variable "AZURE_STORAGE_CONNECTION_STRING" {
  type      = string
  sensitive = true
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
}

variable "GP2GP_TRANSLATOR_USER_DB_PASSWORD" {
  type      = string
  sensitive = true
}

variable "GPC_FACADE_USER_DB_PASSWORD" {
  type      = string
  sensitive = true
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

variable "POSTGRES_PASSWORD" {
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

## Application Environment Variables ##

variable "AWS_REGION" {
  type    = string
  default = "eu-west-2"
}

variable "GP2GP_AMQP_BROKERS" {
  type    = string
  default = "amqp://localhost:5672"
}

variable "GP2GP_AMQP_MAX_REDELIVERIES" {
  type    = string
  default = "3"
}

variable "GP2GP_COSMOS_DB_ENABLED" {
  type    = string
  default = "false"
}

variable "GP2GP_GPC_GET_URL" {
  type = string
}

variable "GP2GP_GPC_STRUCTURED_FHIR_BASE" {
  type = string
}

variable "GP2GP_LARGE_ATTACHMENT_THRESHOLD" {
  type = string
}

variable "GP2GP_LARGE_EHR_EXTRACT_THRESHOLD" {
  type = string
}

variable "GP2GP_LOGGING_LEVEL" {
  type    = string
  default = "DEBUG"
}
variable "GP2GP_MHS_INBOUND_QUEUE" {
  type = string
}
variable "GP2GP_MHS_OUTBOUND_URL" {
  type = string
}
variable "GP2GP_MONGO_DATABASE_NAME" {
  type = string
}
variable "GP2GP_MONGO_TTL" {
  type = string
}
variable "GP2GP_MONGO_URI" {
  type = string
}
variable "GP2GP_SERVER_PORT" {
  type    = number
  default = 8183
}

variable "GP2GP_STORAGE_CONTAINER_NAME" {
  type    = string
  default = "gp2gp-storage-bucket"
}

variable "GP2GP_STORAGE_TYPE" {
  type    = string
  default = null
}

variable "GP2GP_TRANSLATOR_SERVER_PORT" {
  type = string
}

variable "GPC_CONSUMER_LOGGING_LEVEL" {
  type    = string
  default = "DEBUG"
}

variable "GPC_CONSUMER_SDS_APIKEY" {
  type    = string
}

variable "GPC_CONSUMER_SDS_URL" {
  type    = string
  default = "http://localhost:8080/spine-directory/"
}

variable "GPC_CONSUMER_SERVER_PORT" {
  type    = number
  default = 8090
}

variable "GPC_CONSUMER_SPINE_CLIENT_CERT" {
  type    = string
  default = null
}

variable "MAX_RESYNC_RETRIES" {
  type    = number
  default = 3
}

variable "MHS_AMQP_BROKER" {
  type    = string
  default = "amqp://activemq:5672"
}

variable "MHS_AMQP_MAX_REDELIVERIES" {
  type    = number
  default = 3
}

variable "MHS_BASE_URL" {
  type = string
}

variable "MHS_DB_ENDPOINT_URL" {
  type    = string
  default = "https://dynamodb.eu-west-2.amazonaws.com"
}

variable "MHS_FORWARD_RELIABLE_ENDPOINT_URL" {
  type = string
}

variable "MHS_INBOUND_HEALTHCHECK_SERVER_PORT" {
  type    = number
  default = 8083
}

variable "MHS_INBOUND_PORT" {
  type    = number
  default = 443
}

variable "MHS_INBOUND_QUEUE_MESSAGE_TTL_IN_SECONDS" {
  type    = number
  default = 1000
}

variable "MHS_INBOUND_SERVICE_PORTS" {
  type    = string
  default = "443,8084"
}

variable "MHS_INBOUND_USE_SSL" {
  type    = bool
  default = false
}

variable "MHS_LOG_LEVEL" {
  type    = string
  default = "DEBUG"
}

variable "MHS_OUTBOUND_ROUTING_LOOKUP_METHOD" {
  type = string
}

variable "MHS_OUTBOUND_VALIDATE_CERTIFICATE" {
  type = string
}

variable "MHS_QUEUE_NAME" {
  type = string
}

variable "MHS_RESYNC_INTERVAL" {
  type = string
}

variable "MHS_SDS_API_KEY" {
  type = string
}

variable "MHS_SDS_API_URL" {
  type = string
}

variable "MHS_SPINE_ORG_CODE" {
  type = string
}

variable "MHS_SPINE_REQUEST_MAX_SIZE" {
  type = string
}

variable "MHS_SPINE_ROUTE_LOOKUP_URL" {
  type = string
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
  type = string
}

variable "PS_AMQP_MAX_REDELIVERIES" {
  type    = number
  default = 3
}

variable "PS_DAISY_CHAINING_ACTIVE" {
  type    = bool
  default = false
}

variable "PS_DB_URL" {
  type    = string
  default = "jdbc:postgresql://localhost:5436/patient_switching"
}

variable "PS_LOGGING_LEVEL" {
  type    = string
  default = "DEBUG"
}

variable "PS_QUEUE_NAME" {
  type = string
}

variable "STORAGE_CONTAINER_NAME" {
  type = string
}

variable "STORAGE_REFERENCE" {
  type = string
}

variable "STORAGE_REGION" {
  type = string
}

variable "STORAGE_TYPE" {
  type = string
}

variable "SUPPORTED_FILE_TYPES" {
  type    = string
  default = "application/msword,application/vnd.openxmlformats-officedocument.wordprocessingml.document,application/msoutlook,text/rtf,text/plain,image/bmp,image/gif,image/jpeg,image/png,image/tiff,application/xml,audio/x-aiff,audio/x-mpegurl,audio/mpeg,audio/x-wav,audio/x-ms-wma,video/3gpp2,video/3gpp,video/x-ms-asf,video/x-ms-asf,video/x-msvideo,video/x-flv,video/quicktime,video/mp4,video/mpeg,audio/vnd.rn-realaudio,application/x-shockwave-flash,video/x-ms-vob,video/x-ms-wmv,application/postscript,application/postscript,image/svg+xml,image/x-pict,application/pdf,application/vnd.openxmlformats-package.relationships+xml,text/css,text/html,application/xhtml+xml,text/plain,application/json,text/xml,application/xml,application/pdf,audio/basic,audio/mpeg,image/png,image/gif,image/jpeg,image/tiff,video/mpeg,application/msword,application/octet-stream,text/csv,application/dicom,application/zip,application/x-rar-compressed,application/x-gzip,application/vnd.ms-excel,application/vnd.openxmlformats-officedocument.spreadsheetml.sheet,application/x-mplayer2,audio/x-au,application/x-troff-msvideo,video/msvideo,image/x-windows-bmp,application/pkix-cert,application/x-x509-ca-cert,application/cdf,application/x-cdf,application/x-netcdf,application/x-x509-user-cert,application/EDIFACT,application/EDI-X12,application/EDI-Consent,application/hl7-v2,application/hl7-v2+xml,video/x-mpeg,application/pkcs10,application/x-pkcs10,application/pkcs-12,application/x-pkcs12,application/x-pkcs7-signature,application/pkcs7-mime,application/x-pkcs7-mime,application/pkcs7-mime,application/x-pkcs7-mime,application/x-pkcs7-certreqresp,application/pkcs7-signature,application/x-rtf,application/x-compressed,application/x-zip-compressed,multipart/x-zip,application/pgp,application/pgp-keys,application/pgp-signature,application/x-pgp-plugin,application/pgp-encrypted,audio/wav,audio/wave,audio/x-pn-wav,chemical/x-mdl-sdfile,chemical/x-mdl-molfile,chemical/x-pdb,application/x-hl7"
}

## Infrastrcuture Environment ##

variable "cpu" {
  type    = number
  default = 1
}

variable "http_server_port" {
  type    = number
  default = 80
}

variable "memory" {
  type    = string
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
  type    = number
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
  type    = string
  default = "nhsdev/mock-spine-mhs:latest"
}

variable "MQ_USERNAME" {
  type    = string
  default = null
}

variable "MQ_PASSWORD" {
  type    = string
  default = null
}