#!/usr/bin/env bash

####################################
# Snomed file location
export TF_VAR_SNOMED_FILE_LOCATION="/path/to/file/uk_sct2cl_32.10.0_20220216000001Z.zip"; # change

####################################
# Enable daisy chaining

export TF_VAR_PS_DAISY_CHAINING_ACTIVE="true"

####################################
# PS Vars

export TF_VAR_DB_HOST_NAME="ps_db"; #ps_db

export TF_VAR_PS_DB_PORT=5436;
export TF_VAR_PS_DB_HOST="localhost";

export TF_VAR_PS_DB_URL_INTERNAL="jdbc:postgresql://ps_db:5432";
export TF_VAR_PS_DB_OWNER_NAME="postgres";
export TF_VAR_PS_FROM_ODS_CODE="PSS_001";
export TF_VAR_PS_DB_URL="jdbc:postgresql://ps_db:5432";
export TF_VAR_PS_DB_OWNER_PASSWORD="secret"; # change
export TF_VAR_PS_DB_OWNER_PASSWORD="secret"; # change
export TF_VAR_POSTGRES_PASSWORD="secret"; # change
export TF_VAR_GPC_FACADE_USER_DB_PASSWORD="secret"; # change
export TF_VAR_GP2GP_TRANSLATOR_USER_DB_PASSWORD="secret"; # change
export TF_VAR_GP2GP_TRANSLATOR_SERVER_PORT=8085;
export TF_VAR_GPC_FACADE_SERVER_PORT=8081;

export TF_VAR_PS_AMQP_MAX_REDELIVERIES=3;
export TF_VAR_MHS_AMQP_MAX_REDELIVERIES=3;
export TF_VAR_MHS_BASE_URL="http://outbound:80/"
export TF_VAR_GP2GP_MHS_OUTBOUND_URL="http://outbound:80"

export TF_VAR_ACTIVE_MQ_PORT="5672";

# PSS queue
export TF_VAR_PS_AMQP_BROKER="amqp://activemq:5672";
export TF_VAR_PS_QUEUE_NAME="pssQueue";
export TF_VAR_PS_AMQP_USERNAME="admin";
export TF_VAR_PS_AMQP_PASSWORD="admin";

# MHS queue
export TF_VAR_MHS_AMQP_BROKER="amqp://activemq:5672";
export TF_VAR_MHS_QUEUE_NAME="mhsQueue";
export TF_VAR_MHS_AMQP_USERNAME="admin";
export TF_VAR_MHS_AMQP_PASSWORD="admin";

####################################
# LOGGING

export TF_VAR_PS_LOGGING_LEVEL="DEBUG";