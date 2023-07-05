## VPC Module ##
// All the below can be put in to a tf module setting up the vpc
// outputs:
// - public subnet ids
// - private subnet ids

resource "aws_vpc" "nia_gp2gp_vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true
  enable_dns_support = true

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
    cidr_block = var.allow_all_cidr_block
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
    cidr_blocks = [var.allow_all_ipv6_cidr_block]
  }

  //TODO: restrict access to match current restrictions

  //ACCEPT TRAFFIC TO FACADE PORT 8081
  ingress {
    from_port = 8081
    protocol  = "TCP"
    to_port   = 8081
    cidr_blocks = [var.allow_all_cidr_block]
    description = "Facade Traffic"
  }

  //ACCEPT TRAFFIC TO INBOUND PORT 443
  ingress {
    from_port = 443
    protocol  = "TCP"
    to_port   = 443
    cidr_blocks = [var.allow_all_cidr_block]
    description = "Inbound Traffic"
  }

  //ACCEPT TRAFFIC TO MOCK SPINE PORT 8086
  ingress {
    from_port = 8086
    protocol  = "TCP"
    to_port   = 8086
    cidr_blocks = [var.allow_all_cidr_block]
    description = "Mock Spine"
  }

  egress {
    //allow all
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.allow_all_cidr_block]
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
    cidr_blocks      = [var.allow_all_cidr_block]
    ipv6_cidr_blocks = [var.allow_all_ipv6_cidr_block]
  }

  tags = {
    Name = "nia_gp2gp_db_sg"
  }

}

resource "aws_security_group" "nia_gp2gp_mq" {
  name        = "nia_gp2gp_mq"
  description = "Security group for mq"
  vpc_id = aws_vpc.nia_gp2gp_vpc.id

  ingress {
    description     = "Allow traffic to message queue"
    from_port       = "5671"
    protocol        = "tcp"
    to_port         = "5671"
    security_groups = [aws_security_group.nia_gp2gp_dmz.id]
  }

  egress {
    //allow all
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = [var.allow_all_cidr_block]
    ipv6_cidr_blocks = [var.allow_all_ipv6_cidr_block]
  }

  tags = {
    Name = "nia_gp2gp_mq_sg"
  }

}

resource "aws_security_group" "ps_db_migration" {
  name        = "ps_db_migration"
  description = "Security group for db migration"
  vpc_id = aws_vpc.nia_gp2gp_vpc.id

  ingress {
    description     = "Allow PS DB traffic"
    from_port       = "5432"
    protocol        = "tcp"
    to_port         = "5432"
    security_groups = [aws_security_group.nia_gp2gp_dmz.id]
  }

  egress {
    //allow all
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = [var.allow_all_cidr_block]
    ipv6_cidr_blocks = [var.allow_all_ipv6_cidr_block]
  }

  tags = {
    Name = "ps_db_migration"
  }

}

## ELB Module ##
// All the below can be put in to a tf module setting up load balancing
// outputs:
// - IP address
// - target group id

resource "aws_lb" "nia_gp2gp_elb" {
  name            = "nia-gp2gp-elb"
  subnets         = [for subnet in aws_subnet.nia_gp2gp_public_subnet : subnet.id]
  load_balancer_type = "network"

  tags = {
    Name = "nia_gp2gp-elb"
  }
}

resource "aws_lb_target_group" "nia_gp2gp_target_group_inbound" {
  target_type  = "ip"
  port = var.MHS_INBOUND_PORT
  protocol = "TCP"
  vpc_id = aws_vpc.nia_gp2gp_vpc.id

  health_check {
    enabled = true
    interval = 300
    path = "/healthcheck"
    matcher = "200-499"
  }
}

resource "aws_lb_target_group" "nia_gp2gp_target_group_spine" {
  target_type  = "ip"
  port = var.MOCK_SPINE_PORT
  protocol = "TCP"
  vpc_id = aws_vpc.nia_gp2gp_vpc.id

  health_check {
    enabled = true
    interval = 300
    path = "/"
    matcher = "200-499"
  }
}

resource "aws_lb_target_group" "nia_gp2gp_target_group_facade" {
  target_type  = "ip"
  port = var.FACADE_SERVER_PORT
  protocol = "TCP"
  vpc_id = aws_vpc.nia_gp2gp_vpc.id

  health_check {
    enabled = true
    interval = 300
    path = "/"
    matcher = "200-499"
  }
}

resource "aws_lb_listener" "mhs_inbound" {
  load_balancer_arn = aws_lb.nia_gp2gp_elb.arn
  port           = var.MHS_INBOUND_PORT
  protocol       = "TCP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nia_gp2gp_target_group_inbound.arn
  }
}

resource "aws_lb_listener" "mock_spine" {
  load_balancer_arn = aws_lb.nia_gp2gp_elb.arn
  port           = var.MOCK_SPINE_PORT
  protocol       = "TCP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nia_gp2gp_target_group_spine.arn
  }
}

resource "aws_lb_listener" "facade" {
  load_balancer_arn = aws_lb.nia_gp2gp_elb.arn
  port           = var.FACADE_SERVER_PORT
  protocol       = "TCP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nia_gp2gp_target_group_facade.arn
  }
}

## ECS Module ##

resource "aws_ecs_cluster" "nia_gp2gp_cluster" {
  name = "gp2gp-ps-chain"
}