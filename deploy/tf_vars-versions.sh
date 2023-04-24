#!/usr/bin/env bash

export TF_VAR_MHS_INBOUND_VERSION="nhsdev/nia-mhs-inbound:1.2.5-amd64"  # has an arm64 and amd64 version
export TF_VAR_MHS_OUTBOUND_VERSION="nhsdev/nia-mhs-outbound:1.2.5-amd64" # has an arm64 and amd64 version
export TF_VAR_PS_TRANSLATOR_VERSION="nhsdev/nia-ps-adaptor:0.7-amd64" # has an arm64 and amd64 version
export TF_VAR_PS_FACADE_VERSION="nhsdev/nia-ps-facade:0.4-amd64" # has an arm64 and amd64 version
export TF_VAR_PS_DB_MIGRATION_VERSION="nhsdev/nia-ps-db-migration:0.3-amd64" # has an arm64 and amd64 version

export TF_VAR_ACTIVEMQ_VERSION="nhsdev/nia-ps-activemq:0.1-amd64" # has an arm64 and amd64 version
export TF_VAR_POSTGRES_VERSION="postgres:14.0"
export TF_VAR_DYNAMODB_VERSION="nhsdev/nia-dynamodb-local:1.0.3"
export TF_VAR_REDIS_VERSION="redis"
export TF_VAR_MONGODB_VERSION="mongo"

export TF_VAR_GP2GP_ADAPTOR_VERSION="nhsdev/nia-gp2gp-adaptor:1.5.9-amd64"  # has an arm64 and amd64 version
export TF_VAR_GPCC_ADAPTOR_VERSION="nhsdev/nia-gpc-consumer-adaptor:0.3.3" # or arm version: "nhsdev/nia-gpcc-gp2gp-invest:0.1"