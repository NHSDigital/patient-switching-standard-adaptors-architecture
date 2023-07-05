resource "aws_mq_configuration" "gp2gp_ps_config" {
  description    = "PS Config"
  name           = "gp2gp_ps_config"
  engine_type    = var.mq_engine_type
  engine_version = var.mq_engine_version

  data = <<DATA
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<broker xmlns="http://activemq.apache.org/schema/core">
		<destinationPolicy>
			<policyMap>
				<policyEntries>
					<policyEntry topic=">">
						<pendingMessageLimitStrategy>
							<constantPendingMessageLimitStrategy limit="1000"/>
						</pendingMessageLimitStrategy>
					</policyEntry>
					<policyEntry queue=">">
						<deadLetterStrategy>
							<individualDeadLetterStrategy queuePrefix="DLQ." useQueueForQueueMessages="true" processNonPersistent="true"/>
						</deadLetterStrategy>
					</policyEntry>
				</policyEntries>
			</policyMap>
		</destinationPolicy>
  <plugins>
    <forcePersistencyModeBrokerPlugin persistenceFlag="true"/>
    <statisticsBrokerPlugin/>
    <timeStampingBrokerPlugin ttlCeiling="86400000" zeroExpirationOverride="86400000"/>
  </plugins>
</broker>
DATA
}

resource "aws_mq_broker" "gp2gp_ps_broker" {
  broker_name = "gp2gp_ps_broker"

  engine_type    = var.mq_engine_type
  engine_version = var.mq_engine_version
  host_instance_type = var.mq_host_type
  #  deployment_mode = "ACTIVE_STANDBY_MULTI_AZ"

  subnet_ids = [aws_subnet.nia_gp2gp_public_subnet[0].id]
  security_groups = [aws_security_group.nia_gp2gp_mq.id]

  configuration {
    id = aws_mq_configuration.gp2gp_ps_config.id
    revision = aws_mq_configuration.gp2gp_ps_config.latest_revision
  }

  logs {
    general = true
  }

  user {
    username = var.MQ_USERNAME
    password = var.MQ_PASSWORD
    console_access = true
  }
}
