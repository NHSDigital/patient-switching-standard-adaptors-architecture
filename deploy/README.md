The user of this account needs to have the following policies:


 - AmazonECSTaskExecutionRolePolicy
 - AmazonECS_FullAccess
 - AmazonVPCFullAccess
 - ContainerRegistryFullAccess 
 - Custom policy that gives user permissions to the service "Elastic Container Registry" and allows to pull/push/etc.. images to ECR Repository in AWS
 - Custom policy that gives user permissions to the service "System Manager" and allows user to get/put/delete/etc.. parameters



POLICIES

 Custom policy that gives user permissions to the service "Elastic Container Registry" and allows to pull/push/etc.. images to ECR Repository in AWS

 {
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "ecr:PutImageScanningConfiguration",
                "ecr:DescribeImages",
                "ecr:DescribeRepositories",
                "ecr:BatchDeleteImage",
                "ecr:ListImages",
                "ecr:PutImage"
            ],
            "Resource": "arn:aws:ecr:eu-west-2:657333224651:repository/*"
        },
        {
            "Sid": "VisualEditor1",
            "Effect": "Allow",
            "Action": [
                "ecr:CreateRepository",
                "ecr:DescribePullThroughCacheRules"
            ],
            "Resource": "*"
        }
    ]
}





Custom policy that gives user permissions to the service "System Manager" and allows user to get/put/delete/etc.. parameters

{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "ssm:PutParameter",
                "ssm:DeleteParameter",
                "ssm:ListTagsForResource",
                "ssm:GetParameters",
                "ssm:GetParameter",
                "ssm:DeleteParameters"
            ],
            "Resource": "arn:aws:ssm:eu-west-2:657333224651:parameter/*"
        },
        {
            "Sid": "VisualEditor1",
            "Effect": "Allow",
            "Action": "ssm:DescribeParameters",
            "Resource": "*"
        }
    ]
}

NOTE: in the "Resource" property(in the JSON object above) we can allow the user to only access parameters that start with a String




KEEP A NOTE OF THE FIELDS BELLOW

user =  YOUR-USERNAME
accountID =  https://YOUR-ACCOUNT-ID.signin.aws.amazon.com/console
password = YOUR-PASSWORD
region = eu-west-2

access_key_id = YOUR-ACCESS-KEY-ID
secret_access_key = YOUR-SECRET-ACCESS-KEY



A Role ecsTaskExecutionRole need to be created for tasks to run on Clusters

	this role need the following policies
		- AmazonECS_FullAccess
		- AmazonECSTaskExecutionRolePolicy
		- Custom policy that allows the tasks to get parameters (Environmental Variables from Param store) (name example = get_parameters_policy)
			an example of the policy below :

					{
					    "Version": "2012-10-17",
					    "Statement": [
					        {
					            "Sid": "VisualEditor0",
					            "Effect": "Allow",
					            "Action": [
					                "ssm:GetParametersByPath",
					                "ssm:GetParameters",
					                "ssm:GetParameter"
					            ],
					            "Resource": "arn:aws:ssm:eu-west-2:657333224651:parameter/*"
					        }
					    ]
					}



/////////////////////////////////


Pre-steps(these steps are done in a local computer):


- Download AWS CLI latest version
	- open command line and run: 
		- "aws configure"
		-  answer questions asked in this command

		//need secret access key


 
Upload the images to ECR (ECR = AWS Image Repository/similar to docker hub) (these steps are done in a local computer):
	

	1 -  Build Docker Images in a local computer
		 - example: "docker build -t {$CONTAINER-NAME}"

	2 - Login to ECR (from command line)
		 - replace {$REGIONHERE}, {$ACCOUNTIDHERE}, {$REGIONHERE} in the command below
		 - aws ecr get-login-password --region {$REGIONHERE} | docker login --username AWS --password-stdin {$ACCOUNTIDHERE}.dkr.ecr.{$REGIONHERE}.amazonaws.com

	3 - Create ECR Repository in AWS (example Name = nhs-niad-repository)

	4 - Tag the image version
		 - docker tag {$CONTAINER-NAME}:{YOUR-VERSION} {$ACCOUNTIDHERE}.dkr.ecr.{$YOURREGION}.amazonaws.com/{$YOUR-AWS-REPO}:{$YOUR-IMAGE-TAG}

		 - Example of the Commands Used to tag Docker images 
		 	(do not push the docker images that are going to be pull from Docker Hub. Only Push Images build locally. the example bellow are examples)
		 		NOTE: images not present in docker hub = suite_mock-spine-mhs, mhs-inbound-sa

				docker tag local/mhs-inbound-sa:latest {$CONTAINER-NAME}.dkr.ecr.{$YOURREGION}.amazonaws.com/{$nhs-niad-repository}:{$IMAGE-NAME}

				docker tag local/mhs-inbound-sa:latest 657333224651.dkr.ecr.eu-west-2.amazonaws.com/nhs-niad-repository:mhs-inbound-sa
				docker tag nhsdev/nia-mhs-outbound:1.2.2 657333224651.dkr.ecr.eu-west-2.amazonaws.com/nhs-niad-repository:nia-mhs-outbound
				docker tag nhsdev/nia-ps-facade:0.2 657333224651.dkr.ecr.eu-west-2.amazonaws.com/nhs-niad-repository:nia-ps-facade
				docker tag nhsdev/nia-ps-adaptor:0.3 657333224651.dkr.ecr.eu-west-2.amazonaws.com/nhs-niad-repository:nia-ps-adaptor
				docker tag postgres:14.0 657333224651.dkr.ecr.eu-west-2.amazonaws.com/nhs-niad-repository:postgres
				docker tag nhsdev/nia-ps-db-migration:0.2 657333224651.dkr.ecr.eu-west-2.amazonaws.com/nhs-niad-repository:nia-ps-db-migration
				docker tag nhsdev/nia-dynamodb-local:1.0.3 657333224651.dkr.ecr.eu-west-2.amazonaws.com/nhs-niad-repository:nia-dynamodb-local
				docker tag test-suite_mock-spine-mhs:latest 657333224651.dkr.ecr.eu-west-2.amazonaws.com/nhs-niad-repository:test-suite_mock-spine-mhs
				docker tag test-suite_activemq:latest 657333224651.dkr.ecr.eu-west-2.amazonaws.com/nhs-niad-repository:test-suite_activemq

	5 - Upload the image
		 - docker push {$ACCOUNTIDHERE}.dkr.ecr.{$YOURREGION}.amazonaws.com/{$YOUR-AWS-REPO}:{$YOUR-IMAGE-TAG}
		 - Example of the Commands Used to push Docker images 
		 	(do not push the docker images that are going to be pull from Docker Hub. Only Push Images build locally. the example bellow are examples)
		 		NOTE: images not present in docker hub = suite_mock-spine-mhs, mhs-inbound-sa

			docker push 657333224651.dkr.ecr.eu-west-2.amazonaws.com/nhs-niad-repository:mhs-inbound-sa
			docker push 657333224651.dkr.ecr.eu-west-2.amazonaws.com/nhs-niad-repository:nia-mhs-outbound
			docker push 657333224651.dkr.ecr.eu-west-2.amazonaws.com/nhs-niad-repository:nia-ps-facade
			docker push 657333224651.dkr.ecr.eu-west-2.amazonaws.com/nhs-niad-repository:nia-ps-adaptor
			docker push 657333224651.dkr.ecr.eu-west-2.amazonaws.com/nhs-niad-repository:postgres
			docker push 657333224651.dkr.ecr.eu-west-2.amazonaws.com/nhs-niad-repository:nia-ps-db-migration
			docker push 657333224651.dkr.ecr.eu-west-2.amazonaws.com/nhs-niad-repository:nia-dynamodb-local
			docker push 657333224651.dkr.ecr.eu-west-2.amazonaws.com/nhs-niad-repository:test-suite_mock-spine-mhs
			docker push 657333224651.dkr.ecr.eu-west-2.amazonaws.com/nhs-niad-repository:test-suite_activemq


Create Parameters in the parameter Store to store Environmental variables for containers(these steps are done in the AWS Console):
	- go to system manager/parameter store

	- create a Parameter and place the value of the environmental variables there:
		example: name = DB_HOST_NAME, value = www.adsda.asdas

		keep a note of the Parameter name "DB_HOST_NAME". when creating a container, you will need to access it

		- accessing parameters from anywhere in the Application = arn:aws:ssm:${YOUR-REGGION}:${YOUR-ACCOUNT-ID}:parameter/${PARAMETER-NAME}
			example "arn:aws:ssm:eu-west-2:657333224651:parameter/DB_HOST_NAME"



		LIST OF PARAMETERS USED ARE AT THE BOTTOM OF THIS FILE

Creating the Networks and VPC (these steps are done in the AWS Console):

	- Create a VPC:

		- create a VPC
			pick ip address: example 10.0.0.0/24
		- go to the VPC created, click on Actions>edit VPC Settings, now tick the boxes: Enable DNS resolution, and Enable DNS hostNames


	- Create a "Public Subnet" and Attach to VPC:
		- create a public subnet, select VPC, add subnet name (example NHS-public-subnet)

	- Create a InternetGateway for the VPC:
		- create a Internet Gateway

	- Create a "Route Table" for the public subnet:
		- create route table, select VPC and add a name (example = NHS-public-route-table)
		- after created the Route Table, 
			- go to RouteTableCreated>edit-routes>search-for-InternetGateway> search select the internet gateway
			- add the ip addresses which traffic is needed to go to the Internet gateway (out of AWS). for everything add = 0.0.0.0/0
				the ip 0.0.0.0/0 (means all traffic) means that all incoming traffic from inside the VPC goes to the internet Gateway


Creating Fargate Containers:


	1 Create a Task Definition:
		/////////////////OVERVIEW OF CONTAINERS AND TASKS////// READ THIS SECTION AND THE SECTION BELLOW BEFORE STARTING TO ADD CONTAINERS//////

		task definitions is where we place the containers, however, for our NHS application; we need to create 2 Task Definitions. 
		We need to create 1 task definition for x64 processors and a 2nd task definition for ARM64 processors, then 
		a 3d one for our last x64 container MockSpineMhs.

		it will look like:

			////////////////////////////////task with containers/////////////
			NHS-TaskDefinition (X64 PROCESSOR)
				activemq
					image: 657333224651.dkr.ecr.eu-west-2.amazonaws.com/nhs-niad-repository:test-suite_activemq
					keys:
						ACTIVE_MQ_PORT - (ValueFrom) = arn:aws:ssm:eu-west-2:657333224651:parameter/ACTIVE_MQ_PORT
							(REMEMBER TO CHANGE REIONS, ACCOUNTID, AND PARAMETER NAME IF NEEDED)
					ports: 
						8161
						5672

				dynamodb
					image: docker.io/nhsdev/nia-dynamodb-local:1.0.3
					ports: 
						8000
				db
					image: docker.io/postgres:14.0
					keys:
						POSTGRES_PASSWORD - (ValueFrom) = arn:aws:ssm:eu-west-2:657333224651:parameter/POSTGRES_PASSWORD
						PS_DB_OWNER_NAME - (ValueFrom) = arn:aws:ssm:eu-west-2:657333224651:parameter/PS_DB_OWNER_NAME
						PS_DB_PORT - (ValueFrom) = arn:aws:ssm:eu-west-2:657333224651:parameter/PS_DB_PORT
							(REMEMBER TO CHANGE REIONS, ACCOUNTID, AND PARAMETER NAME IF NEEDED)

					ports: 
						5432
				outbound
					image: docker.io/nhsdev/nia-mhs-outbound:1.2.2
					keys:
						AWS_ACCESS_KEY_ID - (VALUE)= "FILL IN"
						AWS_SECRET_ACCESS_KEY - (VALUE) = "FILL IN"
						MAX_RESYNC_RETRIES - (ValueFrom) = arn:aws:ssm:eu-west-2:657333224651:parameter/MAX_RESYNC_RETRIES
						MHS_DB_ENDPOINT_URL - (ValueFrom) = arn:aws:ssm:eu-west-2:657333224651:parameter/MHS_DB_ENDPOINT_URL
						MHS_FORWARD_RELIABLE_ENDPOINT_URL - (ValueFrom) = arn:aws:ssm:eu-west-2:657333224651:parameter/MHS_FORWARD_RELIABLE_ENDPOINT_URL
						MHS_LOG_LEVEL - (ValueFrom) = arn:aws:ssm:eu-west-2:657333224651:parameter/MHS_LOG_LEVEL
						MHS_OUTBOUND_PORT - (ValueFrom) = arn:aws:ssm:eu-west-2:657333224651:parameter/MHS_OUTBOUND_PORT
						MHS_OUTBOUND_ROUTING_LOOKUP_METHOD - (ValueFrom) = arn:aws:ssm:eu-west-2:657333224651:parameter/MHS_OUTBOUND_ROUTING_LOOKUP_METHOD
						MHS_OUTBOUND_VALIDATE_CERTIFICATE - (ValueFrom) = arn:aws:ssm:eu-west-2:657333224651:parameter/MHS_OUTBOUND_VALIDATE_CERTIFICATE
						MHS_RESYNC_INTERVAL - (ValueFrom) = arn:aws:ssm:eu-west-2:657333224651:parameter/MHS_RESYNC_INTERVAL
						MHS_SECRET_CA_CERTS - (ValueFrom) = arn:aws:ssm:eu-west-2:657333224651:parameter/MHS_SECRET_CA_CERTS
						MHS_SECRET_CLIENT_CERT - (ValueFrom) = arn:aws:ssm:eu-west-2:657333224651:parameter/MHS_SECRET_CLIENT_CERT
						MHS_SECRET_CLIENT_KEY - (ValueFrom) = arn:aws:ssm:eu-west-2:657333224651:parameter/MHS_SECRET_CLIENT_KEY
						MHS_SECRET_PARTY_KEY - (ValueFrom) = arn:aws:ssm:eu-west-2:657333224651:parameter/MHS_SECRET_PARTY_KEY
						MHS_SPINE_ORG_CODE - (ValueFrom) = arn:aws:ssm:eu-west-2:657333224651:parameter/MHS_SPINE_ORG_CODE
						MHS_SPINE_REQUEST_MAX_SIZE - (ValueFrom) = arn:aws:ssm:eu-west-2:657333224651:parameter/MHS_SPINE_REQUEST_MAX_SIZE
						MHS_SPINE_ROUTE_LOOKUP_URL - (ValueFrom) = arn:aws:ssm:eu-west-2:657333224651:parameter/MHS_SPINE_ROUTE_LOOKUP_URL
						MHS_STATE_TABLE_NAME - (ValueFrom) = arn:aws:ssm:eu-west-2:657333224651:parameter/MHS_STATE_TABLE_NAME
						MHS_SYNC_ASYNC_STATE_TABLE_NAME - (ValueFrom) = arn:aws:ssm:eu-west-2:657333224651:parameter/MHS_SYNC_ASYNC_STATE_TABLE_NAME
						SERVICE_PORTS - (ValueFrom) = arn:aws:ssm:eu-west-2:657333224651:parameter/SERVICE_PORTS
							(REMEMBER TO CHANGE REIONS, ACCOUNTID, AND PARAMETER NAME IF NEEDED)

					ports: 
						80

				inbound-sa
					image: 657333224651.dkr.ecr.eu-west-2.amazonaws.com/nhs-niad-repository:mhs-inbound-sa
					keys:
						AWS_ACCESS_KEY_ID - (VALUE)= "FILL IN"
						AWS_SECRET_ACCESS_KEY (VALUE) = "FILL IN"
						MHS_INBOUND_QUEUE_BROKERS - (ValueFrom) = arn:aws:ssm:eu-west-2:657333224651:parameter/MHS_INBOUND_QUEUE_BROKERS
						MHS_SECRET_INBOUND_QUEUE_PASSWORD - (ValueFrom) = arn:aws:ssm:eu-west-2:657333224651:parameter/MHS_SECRET_INBOUND_QUEUE_PASSWORD
						MHS_SECRET_INBOUND_QUEUE_USERNAME - (ValueFrom) = arn:aws:ssm:eu-west-2:657333224651:parameter/MHS_SECRET_INBOUND_QUEUE_USERNAME
						MHS_DB_ENDPOINT_URL - (ValueFrom) = arn:aws:ssm:eu-west-2:657333224651:parameter/MHS_DB_ENDPOINT_URL
						MHS_INBOUND_HEALTHCHECK_SERVER_PORT - (ValueFrom) = arn:aws:ssm:eu-west-2:657333224651:parameter/MHS_INBOUND_HEALTHCHECK_SERVER_PORT
						MHS_INBOUND_PORT - (ValueFrom) = arn:aws:ssm:eu-west-2:657333224651:parameter/MHS_INBOUND_PORT
						MHS_INBOUND_QUEUE_MESSAGE_TTL_IN_SECONDS - (ValueFrom) = arn:aws:ssm:eu-west-2:657333224651:parameter/MHS_INBOUND_QUEUE_MESSAGE_TTL_IN_SECONDS
						MHS_INBOUND_SERVICE_PORTS - (ValueFrom) = arn:aws:ssm:eu-west-2:657333224651:parameter/MHS_INBOUND_SERVICE_PORTS
						MHS_INBOUND_USE_SSL - (ValueFrom) = arn:aws:ssm:eu-west-2:657333224651:parameter/MHS_INBOUND_USE_SSL
						MHS_LOG_LEVEL - (ValueFrom) = arn:aws:ssm:eu-west-2:657333224651:parameter/MHS_LOG_LEVEL
						MHS_INBOUND_QUEUE_NAME - (ValueFrom) = arn:aws:ssm:eu-west-2:657333224651:parameter/MHS_INBOUND_QUEUE_NAME
						MHS_SECRET_CA_CERTS - (ValueFrom) = arn:aws:ssm:eu-west-2:657333224651:parameter/MHS_SECRET_CA_CERTS
						MHS_SECRET_CLIENT_CERT - (ValueFrom) = arn:aws:ssm:eu-west-2:657333224651:parameter/MHS_SECRET_CLIENT_CERT
						MHS_SECRET_CLIENT_KEY - (ValueFrom) = arn:aws:ssm:eu-west-2:657333224651:parameter/MHS_SECRET_CLIENT_KEY
						MHS_SECRET_PARTY_KEY - (ValueFrom) = arn:aws:ssm:eu-west-2:657333224651:parameter/MHS_SECRET_PARTY_KEY
						MHS_STATE_TABLE_NAME - (ValueFrom) = arn:aws:ssm:eu-west-2:657333224651:parameter/MHS_STATE_TABLE_NAME
						MHS_SYNC_ASYNC_STATE_TABLE_NAME - (ValueFrom) = arn:aws:ssm:eu-west-2:657333224651:parameter/MHS_SYNC_ASYNC_STATE_TABLE_NAME
							(REMEMBER TO CHANGE REIONS, ACCOUNTID, AND PARAMETER NAME IF NEEDED)

					ports: 
						443
						8079
						8083

			NHS-TaskDefinition-ARM64 (ARM64 PROCESSOR)
				db-migration (not essential container / neet to untick this box)
					image: docker.io/nhsdev/nia-ps-db-migration:0.2
					keys:
						GP2GP_TRANSLATOR_USER_DB_PASSWORD - (ValueFrom) = arn:aws:ssm:eu-west-2:657333224651:parameter/GP2GP_TRANSLATOR_USER_DB_PASSWORD
						GPC_FACADE_USER_DB_PASSWORD - (ValueFrom) = arn:aws:ssm:eu-west-2:657333224651:parameter/GPC_FACADE_USER_DB_PASSWORD
						POSTGRES_PASSWORD - (ValueFrom) = arn:aws:ssm:eu-west-2:657333224651:parameter/POSTGRES_PASSWORD
						PS_DB_OWNER_NAME - (ValueFrom) = arn:aws:ssm:eu-west-2:657333224651:parameter/PS_DB_OWNER_NAME
						PS_DB_URL - (ValueFrom) = arn:aws:ssm:eu-west-2:657333224651:parameter/PS_DB_URL
							(REMEMBER TO CHANGE REIONS, ACCOUNTID, AND PARAMETER NAME IF NEEDED)


				ps-facade 	(Depend on "db-migration")
					image: docker.io/nhsdev/nia-ps-facade:0.2
					keys:
						GPC_FACADE_SERVER_PORT - (ValueFrom) = arn:aws:ssm:eu-west-2:657333224651:parameter/GPC_FACADE_SERVER_PORT
						GPC_FACADE_USER_DB_PASSWORD - (ValueFrom) = arn:aws:ssm:eu-west-2:657333224651:parameter/GPC_FACADE_USER_DB_PASSWORD
						PS_AMQP_BROKER - (ValueFrom) = arn:aws:ssm:eu-west-2:657333224651:parameter/PS_AMQP_BROKER
						PS_AMQP_MAX_REDELIVERIES - (ValueFrom) = arn:aws:ssm:eu-west-2:657333224651:parameter/PS_AMQP_MAX_REDELIVERIES
						PS_AMQP_PASSWORD - (ValueFrom) = arn:aws:ssm:eu-west-2:657333224651:parameter/PS_AMQP_PASSWORD
						PS_AMQP_USERNAME - (ValueFrom) = arn:aws:ssm:eu-west-2:657333224651:parameter/PS_AMQP_USERNAME
						PS_DB_URL - (ValueFrom) = arn:aws:ssm:eu-west-2:657333224651:parameter/PS_DB_URL
						PS_LOGGING_LEVEL - (ValueFrom) = arn:aws:ssm:eu-west-2:657333224651:parameter/PS_LOGGING_LEVEL
						PS_QUEUE_NAME - (ValueFrom) = arn:aws:ssm:eu-west-2:657333224651:parameter/PS_QUEUE_NAME
							(REMEMBER TO CHANGE REIONS, ACCOUNTID, AND PARAMETER NAME IF NEEDED)

					ports: 
						8081

				ps-translator (Depend on "db-migration")
					image: docker.io/nhsdev/nia-ps-adaptor:0.3
					keys:
						GP2GP_TRANSLATOR_SERVER_PORT - (ValueFrom) = arn:aws:ssm:eu-west-2:657333224651:parameter/GP2GP_TRANSLATOR_SERVER_PORT
						GP2GP_TRANSLATOR_USER_DB_PASSWORD - (ValueFrom) = arn:aws:ssm:eu-west-2:657333224651:parameter/GP2GP_TRANSLATOR_USER_DB_PASSWORD
						MHS_AMQP_BROKER - (ValueFrom) = arn:aws:ssm:eu-west-2:657333224651:parameter/MHS_AMQP_BROKER
						MHS_AMQP_MAX_REDELIVERIES - (ValueFrom) = arn:aws:ssm:eu-west-2:657333224651:parameter/MHS_AMQP_MAX_REDELIVERIES
						MHS_AMQP_PASSWORD - (ValueFrom) = arn:aws:ssm:eu-west-2:657333224651:parameter/MHS_AMQP_PASSWORD
						MHS_AMQP_USERNAME - (ValueFrom) = arn:aws:ssm:eu-west-2:657333224651:parameter/MHS_AMQP_USERNAME
						MHS_BASE_URL - (ValueFrom) = arn:aws:ssm:eu-west-2:657333224651:parameter/MHS_BASE_URL
						MHS_QUEUE_NAME - (ValueFrom) = arn:aws:ssm:eu-west-2:657333224651:parameter/MHS_QUEUE_NAME
						PS_AMQP_BROKER - (ValueFrom) = arn:aws:ssm:eu-west-2:657333224651:parameter/PS_AMQP_BROKER
						PS_AMQP_MAX_REDELIVERIES - (ValueFrom) = arn:aws:ssm:eu-west-2:657333224651:parameter/PS_AMQP_MAX_REDELIVERIES
						PS_AMQP_PASSWORD - (ValueFrom) = arn:aws:ssm:eu-west-2:657333224651:parameter/PS_AMQP_PASSWORD
						PS_AMQP_USERNAME - (ValueFrom) = arn:aws:ssm:eu-west-2:657333224651:parameter/PS_AMQP_USERNAME
						PS_DB_URL - (ValueFrom) = arn:aws:ssm:eu-west-2:657333224651:parameter/PS_DB_URL
						PS_LOGGING_LEVEL - (ValueFrom) = arn:aws:ssm:eu-west-2:657333224651:parameter/PS_LOGGING_LEVEL
						PS_QUEUE_NAME - (ValueFrom) = arn:aws:ssm:eu-west-2:657333224651:parameter/PS_QUEUE_NAME
						SUPPORTED_FILE_TYPES - (ValueFrom) = arn:aws:ssm:eu-west-2:657333224651:parameter/SUPPORTED_FILE_TYPES
							(REMEMBER TO CHANGE REIONS, ACCOUNTID, AND PARAMETER NAME IF NEEDED)

					ports: 
						8085
			NHS-TaskDefinition-SmokeSpineMHS  (X64)
				mock-spine-mhs
					image: 657333224651.dkr.ecr.eu-west-2.amazonaws.com/nhs-niad-repository:test-suite_mock-spine-mhs
					keys:
						GP2GP_TRANSLATOR_USER_DB_PASSWORD - (ValueFrom) = arn:aws:ssm:eu-west-2:657333224651:parameter/GP2GP_TRANSLATOR_USER_DB_PASSWORD
						MOCK_SPINE_MHS_FORWARD_RELIABLE_PORT - (ValueFrom) = arn:aws:ssm:eu-west-2:657333224651:parameter/MOCK_SPINE_MHS_FORWARD_RELIABLE_PORT
						MOCK_SPINE_MHS_OUTBOUND_LOG_LEVEL - (ValueFrom) = arn:aws:ssm:eu-west-2:657333224651:parameter/MOCK_SPINE_MHS_OUTBOUND_LOG_LEVEL
						MOCK_SPINE_MHS_PORT - (ValueFrom) = arn:aws:ssm:eu-west-2:657333224651:parameter/MOCK_SPINE_MHS_PORT
						PS_DB_URL - (ValueFrom) = arn:aws:ssm:eu-west-2:657333224651:parameter/PS_DB_URL
							(REMEMBER TO CHANGE REIONS, ACCOUNTID, AND PARAMETER NAME IF NEEDED)
					ports: 
						8086
						8443
			////////////////////////////////end of task with containers/////////////

		== SEE STEPS BELOW TO BUILD THE ABOVE TASK ==
		/////////////////END OF OVERVIEW OF CONTAINERS AND TASKS//////////////


		create a Task definition:
			- Select launch type compatibility = Fargate

			- Configure task and container definitions:
				Add a Task Definition Name
				Select the task role for this = ecsTaskExecutionRole


			- Select Task Memory = 2GB for example

			- Select CPU (vCPU) = 1 vCPU for example


			- Add Processor Type (this step is only needed if you need to change the Default x64 processor to ARM64) 
				- go the configure via JSON and search for the property "runtimePlatform" and add cpuArchitecture": "ARM64".
					the file should look like the following:
						    "runtimePlatform": {
						        "operatingSystemFamily": "LINUX",
						        "cpuArchitecture": "ARM64"
						    },
	    	- Add Container:

	    		- go to "Add Container" and click:

	    			in the Standard Section:
	    				- add a container name
	    				- add an image:
	    					syntax for image coming from ECR: ${YOUR-ACCOUNT-ID}.dkr.ecr.${YOUR-REGION}.amazonaws.com/nhs-niad-repository:${DOCKER-IMAGE-PUSSHED-TO-ECR-NAME}
	    					syntax for image coming from DockerHub: docker.io/${DOCKER-IMAGE}:${VERSION}
						- add Port Mappins: check in the docker compose file of the project for this if not sure

					in the Environment Section: 
						- where the environmental variables, add key:
							syntax from the parameter store (you need to change "value" to "valueFrom"): arn:aws:ssm:{$YOURREGION}:{$ACCOUNTIDHERE}:parameter/${PARAMETER-NAME}
								example = arn:aws:ssm:eu-west-2:657333224651:parameter/DB_HOST_NAME

					in the Startup Dependency Ordering:
						- Add a container it needs to wait until "COMPLETE" before starting. for example, the migration needs to start, and after it finishes, the Facade and translator can start
						  for our NHS this is the only case where we add a dependency.

						- AWS will stop the whole task with containers if any "essential containers" fail, so we need to go back to "the Environment Section" and unclick "Essential" if any container stops,
						  for the NHS project, the migration container is unclicked

	  		- now click on create



	1 Create a Cluster
		- Create a Cluster and give it a name (this is where the Task Definitions and Services will be running on)
		- click on the Cluster, and create 3 services in the orders: 
			1 - NHS-TaskDefinition
			2 - NHS-TaskDefinition-ARM64
			3 - NHS-TaskDefinition-SmokeSpineMHS
				wait until services are running before creating another service

		-When creating a Service inside the Cluster
			Configure service
				Launch type = fargate
				Task Definition = select :  NHS-TaskDefinition/NHS-TaskDefinition-ARM64/NHS-TaskDefinition-SmokeSpineMHS
				Service name = ADD-YOUR-NAME
				number of taks = 1      (it determines how many instances it will create of that service)

				click next

			Configure network
				Cluster VPC = select your VPC created
				Subnets = Select your Subnet (Private, or public), for this case we only created a public one
				security groups = create/edit - add all ports you want to accept (we allowed all TCP for now)
				Auto-assign public IP = ENABLED

				Enable service discovery integration = tick this box
					Namespace = create your namespace
					Service discovery name = Name your ServiceDiscoveryName
						NOTE = "ServiceDiscoveryName.NameSpaceValue" will be your host for your URLs (Example "NHS-Service.Local:8080", instead of "outbound:8080", or "localHost:8080")
						 before carrying on, open a new Tab in AWS and add replace the host of all EnvVariableValues 
			
				DNS record type and TTL = 60
			click next until create service


			Click on the service, go to tasks, click on the running task, 
			copy the public IP address. Use that IP to connect to the DB, 
			test it with postman, or the browser.Copy the IP address of 
			each service. you should have one for NHS-TaskDefinition, 
			NHS-TaskDefinition-ARM64, and NHS-TaskDefinition-SmokeSpineMHS.

			examples:

				example formats:
				http://ServicePublicIpAddress/reliablemessaging/forwardreliable    = get
				https://ServicePublicIpAddress:{{inbound-port}}
				jdbc:postgresql://ServicePublicIpAddress:5432/postgres

				examples of use:
				http://13.40.120.120:8086/reliablemessaging/forwardreliable    = get
				https://52.56.187.153:{{inbound-port}}
				jdbc:postgresql://52.56.187.153:5432/postgres

			you should be able to use urls above in postman or the browser

the containers can be access through public IP addresses and they talk to each other
SSL certificates and PSS adaptor giving an error. check env variables and ports to solve any issues













PARAMETERS USED (environmental variables):


ACTIVE_MQ_PORT = 5672
DB_HOST_NAME = NHS-Service.Local
DYNAMODB_HOST_NAME = NHS-Service.Local
DYNAMODB_PORT = 8000
GP2GP_MHS_OUTBOUND_URL = http://NHS-Service.Local:80
GP2GP_TRANSLATOR_SERVER_PORT = 8085
GP2GP_TRANSLATOR_USER_DB_PASSWORD = 123456
MAX_RESYNC_RETRIES = 20
MHS_AMQP_BROKER = amqp://NHS-Service.Local:5672
MHS_AMQP_MAX_REDELIVERIES = 3
MHS_AMQP_PASSWORD = admin
MHS_AMQP_USERNAME = admin
MHS_BASE_URL = http://NHS-Service.Local:80/
MHS_DB_ENDPOINT_URL = http://NHS-Service.Local:8000
MHS_FORWARD_RELIABLE_ENDPOINT_URL = https://NHS-Service.Local:8443/reliablemessaging/forwardreliable
MHS_INBOUND_HEALTHCHECK_SERVER_PORT = 8083
MHS_INBOUND_PORT = 443
MHS_INBOUND_QUEUE_MAX_RETRIES = 3
MHS_INBOUND_QUEUE_MESSAGE_TTL_IN_SECONDS = 1000
MHS_INBOUND_QUEUE_RETRY_DELAY = 500
MHS_INBOUND_SERVICE_PORTS = 443,8084
MHS_INBOUND_USE_SSL = False
MHS_LOG_LEVEL = DEBUG
MHS_QUEUE_NAME = mhsQueue
MHS_RESYNC_INTERVAL = 1

MHS_SECRET_CA_CERTS = "-----BEGIN CERTIFICATE-----
MIIFmzCCA4OgAwIBAgIUMqDLTJb+ZWl7o4sXlPD0B7vB5NkwDQYJKoZIhvcNAQEL
BQAwXTELMAkGA1UEBhMCVUsxEzARBgNVBAgMClNvbWUtU3RhdGUxITAfBgNVBAoM
GEludGVybmV0IFdpZGdpdHMgUHR5IEx0ZDEWMBQGA1UEAwwNZ3AyZ3AtbW5oLWUy
ZTAeFw0yMjA3MDUxMzM1NDJaFw0zMjA3MDIxMzM1NDJaMF0xCzAJBgNVBAYTAlVL
MRMwEQYDVQQIDApTb21lLVN0YXRlMSEwHwYDVQQKDBhJbnRlcm5ldCBXaWRnaXRz
IFB0eSBMdGQxFjAUBgNVBAMMDWdwMmdwLW1uaC1lMmUwggIiMA0GCSqGSIb3DQEB
AQUAA4ICDwAwggIKAoICAQDcLaOTbCaKpBY9D2xJJnCRWMkRNupKn2RFxeSfdjOA
iH5cibZNwUVfO78FwLfgGGdfO50/zZv89TGYobjh0VJGh3JWl8W8XMm7QIXT5ECl
et0/js1Sih8MihvZxrfmebEW4ZSqti58Nyq3SkiZiNioUJs0LaICWQ4KsAQDDdJi
GAQiRQt+4h/gimqc9niHiv3U4K6WYrbOaRy7JNS9dFTdZVpUXkZh9uH4FBvaEhi9
54UXVPduvubdqTMa4e+b59IJ41vO7s1BOT5bupd7r1muAAWHe46y7rwLQ4buFjYl
w//WeO9RKUpoLLYkRKyg+Kd3zF17rjZDBZpi5Bir2IlnXquftL+Dq9EnLVMYN8cw
jijyk/MlYvKIsTX1afbKImU3AeM72+xZ9SQ5QvKsTh8YSyR333tqrIILjAfbXL4Z
yz0ulDKo5xuJ/2ZufA9fEB/uOAWHubx5QYOFNMOBD8oJeqhd95yEMxTM0kGgzNqD
QJbdpeAUVmK7u/MsZ6QRxN5fV0umsmXr8YM/ceq0lD0eqgb7MTl7iRgffap6QS/3
JwOx1yARwiYjbzy4hy+vNNclzRm3vx4eGuRZR2FQDQRCKu36mDBLbgiuC/kUlwfb
MvuzLgB8TF1Tvrcd4VjcBJmCHtIlXGjoCvTWpqETarXrvBVHzVcl8QKl2UAnpVZg
awIDAQABo1MwUTAdBgNVHQ4EFgQUhLh8vkQz8qjtbOtmCics3Xn8FOkwHwYDVR0j
BBgwFoAUhLh8vkQz8qjtbOtmCics3Xn8FOkwDwYDVR0TAQH/BAUwAwEB/zANBgkq
hkiG9w0BAQsFAAOCAgEAU8p+XVo2Cael1STmSLnKR8B/PD/y6gIukmLgoUX1u/NY
N5kgPMeuewgr4hg47CB9noiVDQGn6LLGzWR9HMH+LpxpDIXh7M4mguedkHzx7P/D
K/AeCazOvehWcdcBkKK5oUtIqd4Q3WpJ19V/FbHkNhj+hbI3er8P5SbiXU7aoBJE
J7qpvjkH88WQFkFTRW5y0LXNWZZyDC2X7U/c31UI/aWvmCVv53q8o5SWSgdWXZvg
HV4RqJcDWCnfGlw6c3GteFkI7roWRrBkfGdbfBdNc4WDruTSlYQeb8VAU3Uk3hIj
CrpO2PK670+9hawyzMYtjIvnx1+RebN9w7eHlL6uRw3kVz73vf5do5PVFA/6YaU2
VRsOKxzcRa8piw3b5ZJkpCHTkbo8WetqeVOYC1Glykw/0NaXfVGRvDB1rzVe/6GM
UxIWwRbWUiCJ7vqIxDu4geJOq+UHAXpBqhhocyv7en/ymSzsezOFVbgX7Wbw+oIh
+jBM4M4IZATtW9vFzhytO4WpZUQyahto8PYjauj6hjEjZAKak8kK2DwdjcvWj7/W
xt9hUUWhbTUtFfc95694SpTMzRNq1tH0r8TIpsZI0/KJaKau5M5R+5XTAMr/fo/v
T9etrsihBj08g8wbOxQCCeOuydoGCHAXrKyLHjCAGPp+r8LAJyQtjcWivK4arQg=
-----END CERTIFICATE-----"

MHS_SECRET_CLIENT_CERT = "-----BEGIN CERTIFICATE-----
MIIFPTCCAyUCFAKYCULeFVcQCwXCGCiCFVu09NmzMA0GCSqGSIb3DQEBCwUAMF0x
CzAJBgNVBAYTAlVLMRMwEQYDVQQIDApTb21lLVN0YXRlMSEwHwYDVQQKDBhJbnRl
cm5ldCBXaWRnaXRzIFB0eSBMdGQxFjAUBgNVBAMMDWdwMmdwLW1uaC1lMmUwHhcN
MjIwNzA1MTQwNzM5WhcNMzIwNzAyMTQwNzM5WjBZMQswCQYDVQQGEwJVSzETMBEG
A1UECAwKU29tZS1TdGF0ZTEhMB8GA1UECgwYSW50ZXJuZXQgV2lkZ2l0cyBQdHkg
THRkMRIwEAYDVQQDDAlsb2NhbGhvc3QwggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAw
ggIKAoICAQCv++J5CEdRMbVv7VRLyf4peMzffF43Ws4R0zdKeLn0BL3IXAHdpbPz
eKj3kWW/eqBr1D/QiAxmJgYPmyIY2rCyggDVBLh2QtRKiKzsHGWT+8QjT9UzkxAc
cDHF2tBjdmGnDY6QVHSuWpdlc8aXD+zEpRU7tb65FufhzgwJMpDzMlapckMPYdyC
sqZmQJiMTi7cLRvF1X21X0phx6VaZiIZ1LYism7BGmL3EL8rWtPzpOwXZwQ2ZXpK
uSFhrpbOHoyx/XX+sPTzZx6QYmxFMbQQKnebgj2ziHnQYfGjYMG3u+iGJ6NDCu5Q
MtwhscTE0M/T5WOQ7kINGOjVrT5JOAADajQCQBioFpTf82/jlNgc0lqO81EB6QDg
S9unFNSx5Cc2sBdfXoitzIEB+PoYyAa2OjogCdpo+5wAOaj6Ga5L2q6oVAV+vtuf
XtmdQQWtY12RcsWi1Q/Ju5LnJ2ubkLdOSzMJyufma08s+pd3OHBaZ72FrQ7L/XMk
Tq5qzSUohOaEneOPCKWkxLTJyZn0AqKglbn8qdMMuSLUUF/v6bRKyIUOQ9+/RaeD
sB1hoLSxyiS6d+i5gROYe6nGuIpKf3ggTs5H7Ri/m2AbOm8UjqUfP2U4phfxQJ/7
/eZ72L+UNje5OVN9eTInCWq+D9oQaukhmCL/DX7f87gX1Hseta0cmwIDAQABMA0G
CSqGSIb3DQEBCwUAA4ICAQBZa5zNp8IYJfdYoNMwgy4omq4Mpo+wO1mXyrHxmxsy
3o3oOCvg3+b7WREZRmCfI5BdFRKID5dFenqJVXv21ITRp3yEz21YMAYui2zqlm7E
A+IhyMFAwKwbDSjrU2DsCqodTOX/KVFk6Lvlq+/LPpiTW99aG6NO6gQHm2/5P1kH
FSpPzlIItrEegYEQJd9hBk9AFXsm+uQo6smc+ykriv01AKFQ3uv36SlSYptV88ua
3ZLihHUnToMMMcPUCzYToOFass+W7N4tI7+rI0GPV777gQEQM/KKR+lFvZzUijmK
jRe3uTiMc/r/yHwh+U9uEqjh+Gd5KXRe9+oItE3FcbG4C2tvtud/T7gfdnXV3h1t
A7mdmJII2zLHJjFe2yIBOlHuG/kOryD5mAX+FaGk1NFRdpLVbuheh//C4HZrB+N/
gp418dhX0XcynuekyerV98kVOvlR9I9fQvCegmq5B7bHYICp2w4KmBvntZoQJxUh
yaA5gQ96cu9DIxFvJhkVOKsjqKucS/o9jgwebh2Mazd42cDcdWf4WPOA9FTFvcrf
iZYzqfY3DB0POlCi+wo0AtrsgnUKrc1m7GPiJktj0rdodJ5t8D0AJBXLjtg49c5t
4f5BTpShsUi9oolMK4UuIJT6Rs7xVBbLICFFkOTUq4FcqaBLReUrxPZ90vzQWela
PQ==
-----END CERTIFICATE-----"

MHS_SECRET_CLIENT_KEY = "-----BEGIN RSA PRIVATE KEY-----
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
+8E2oWGLEsKyGk9dYzUUzJUSHM7roH31dA==
-----END RSA PRIVATE KEY-----"
MHS_SECRET_INBOUND_QUEUE_PASSWORD = admin
MHS_SECRET_INBOUND_QUEUE_USERNAME = admin
MHS_SECRET_PARTY_KEY = Y90664-9198273
MHS_SPINE_ORG_CODE = YES
MHS_SPINE_REQUEST_MAX_SIZE = 4999600
MHS_SPINE_ROUTE_LOOKUP_URL = http://NHS-Service.Local:8086
MHS_STATE_TABLE_NAME = mhs_state
MHS_SYNC_ASYNC_STATE_TABLE_NAME = sync_async_state
MOCK_SPINE_MHS_FORWARD_RELIABLE_PORT = 8443
MOCK_SPINE_MHS_OUTBOUND_LOG_LEVEL = DEBUG
MONGODB_PORT = 27017
POSTGRES_PASSWORD = 123456
PS_AMQP_BROKER = amqp://NHS-Service.Local:5672
PS_AMQP_PASSWORD = admin
PS_DB_OWNER_NAME = postgres
PS_DB_OWNER_PASSWORD = 123456
PS_DB_PORT = 5432
PS_DB_URL = jdbc:postgresql://NHS-Service.Local:5432
PS_FROM_ODS_CODE = PSS_001
PS_LOGGING_LEVEL = TRACE
PS_QUEUE_NAME = pssQueue
REDIS_PORT = 6379
BASE_IMAGE_TAG = latest
BUILD_TAG = latest
GPC_FACADE_SERVER_PORT = 8081
GPC_FACADE_USER_DB_PASSWORD = 123456
MHS_INBOUND_QUEUE_BROKERS = amqp://NHS-Service.Local:5672
MHS_INBOUND_QUEUE_NAME = mhsQueue
MHS_OUTBOUND_PORT = 8084
MHS_OUTBOUND_ROUTING_LOOKUP_METHOD = SPINE_ROUTE_LOOKUP
MHS_OUTBOUND_VALIDATE_CERTIFICATE = False
MOCK_SPINE_MHS_PORT = 8086
PS_AMQP_MAX_REDELIVERIES = 3
PS_AMQP_USERNAME = admin
PS_DB_HOST = NHS-Service.Local
PS_DB_URL_INTERNAL = jdbc:postgresql://NHS-Service.Local:5432
SERVICE_PORTS = 443,8084
SUPPORTED_FILE_TYPES = "application/msword,application/vnd.openxmlformats-officedocument.wordprocessingml.document,application/msoutlook,text/rtf,text/plain,image/bmp,image/gif,image/jpeg,image/png,image/tiff,application/xml,audio/x-aiff,audio/x-mpegurl,audio/mpeg,audio/x-wav,audio/x-ms-wma,video/3gpp2,video/3gpp,video/x-ms-asf,video/x-ms-asf,video/x-msvideo,video/x-flv,video/quicktime,video/mp4,video/mpeg,audio/vnd.rn-realaudio,application/x-shockwave-flash,video/x-ms-vob,video/x-ms-wmv,application/postscript,application/postscript,image/svg+xml,image/x-pict,application/pdf,application/vnd.openxmlformats-package.relationships+xml,text/css,text/html,application/xhtml+xml,text/plain,application/json,text/xml,application/xml,application/pdf,audio/basic,audio/mpeg,image/png,image/gif,image/jpeg,image/tiff,video/mpeg,application/msword,application/octet-stream,text/csv,application/dicom,application/zip,application/x-rar-compressed,application/x-gzip,application/vnd.ms-excel,application/vnd.openxmlformats-officedocument.spreadsheetml.sheet,application/x-mplayer2,audio/x-au,application/x-troff-msvideo,video/msvideo,image/x-windows-bmp,application/pkix-cert,application/x-x509-ca-cert,application/cdf,application/x-cdf,application/x-netcdf,application/x-x509-user-cert,application/EDIFACT,application/EDI-X12,application/EDI-Consent,application/hl7-v2,application/hl7-v2+xml,video/x-mpeg,application/pkcs10,application/x-pkcs10,application/pkcs-12,application/x-pkcs12,application/x-pkcs7-signature,application/pkcs7-mime,application/x-pkcs7-mime,application/pkcs7-mime,application/x-pkcs7-mime,application/x-pkcs7-certreqresp,application/pkcs7-signature,application/x-rtf,application/x-compressed,application/x-zip-compressed,multipart/x-zip,application/pgp,application/pgp-keys,application/pgp-signature,application/x-pgp-plugin,application/pgp-encrypted,audio/wav,audio/wave,audio/x-pn-wav,chemical/x-mdl-sdfile,chemical/x-mdl-molfile,chemical/x-pdb,application/x-hl7"
TCP_PORTS = 443



