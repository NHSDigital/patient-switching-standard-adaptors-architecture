#!/usr/bin/env bash

####################################
# Snomed file location
export SNOMED_FILE_LOCATION="/path/to/file/uk_sct2cl_32.10.0_20220216000001Z.zip"; # change

####################################
# Enable daisy chaining

export PS_DAISY_CHAINING_ACTIVE="true"

####################################
# PS Vars

export DB_HOST_NAME="ps_db"; #ps_db

export PS_DB_PORT=5436;
export PS_DB_HOST="localhost";

export PS_DB_URL_INTERNAL="jdbc:postgresql://ps_db:5432";
export PS_DB_OWNER_NAME="postgres";
export PS_FROM_ODS_CODE="PSS_001";
export PS_DB_URL="jdbc:postgresql://ps_db:5432";
export PS_DB_OWNER_PASSWORD="secret"; # change
export PS_DB_OWNER_PASSWORD="secret"; # change
export POSTGRES_PASSWORD="secret"; # change
export GPC_FACADE_USER_DB_PASSWORD="secret"; # change
export GP2GP_TRANSLATOR_USER_DB_PASSWORD="secret"; # change
export GP2GP_TRANSLATOR_SERVER_PORT=8085;
export GPC_FACADE_SERVER_PORT=8081;

export PS_AMQP_MAX_REDELIVERIES=3;
export MHS_AMQP_MAX_REDELIVERIES=3;
export MHS_BASE_URL="http://outbound:80/"
export GP2GP_MHS_OUTBOUND_URL="http://outbound:80"

export ACTIVE_MQ_PORT="5672";

# PSS queue
export PS_AMQP_BROKER="amqp://activemq:5672";
export PS_QUEUE_NAME="pssQueue";
export PS_AMQP_USERNAME="admin";
export PS_AMQP_PASSWORD="admin";

# MHS queue
export MHS_AMQP_BROKER="amqp://activemq:5672";
export MHS_QUEUE_NAME="mhsQueue";
export MHS_AMQP_USERNAME="admin";
export MHS_AMQP_PASSWORD="admin";

####################################
# LOGGING

export PS_LOGGING_LEVEL="DEBUG";