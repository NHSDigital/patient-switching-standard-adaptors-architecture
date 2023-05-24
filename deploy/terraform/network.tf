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

#resource "aws_subnet" "nia_gp2gp_public_subnet_2" {
#  count             = var.subnet_count.public
#  cidr_block        = var.public_subnet_2_cidr_blocks[count.index]
#  vpc_id            = aws_vpc.nia_gp2gp_vpc.id
#  availability_zone = data.aws_availability_zones.available.names[1]
#
#  tags = {
#    Name = "nia_gp2gp_public_subnet_${count.index}"
#  }
#}

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
    cidr_block = "0.0.0.0/0"
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
    cidr_blocks = ["0.0.0.0/0"]
  }

  //TODO: restrict access to match current restrictions

  ingress {
    from_port   = var.ssh_server_port
    to_port     = var.ssh_server_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  //ACCEPT TRAFFIC TO FACADE PORT 8081
  ingress {
    from_port = 8081
    protocol  = "TCP"
    to_port   = 8081
    cidr_blocks = ["0.0.0.0/0"]
    description = "Inbound Traffic"
  }

  egress {
    //allow all
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
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
    description     = "Allow HTTP traffic from only the pubic sg"
    from_port       = "80"
    protocol        = "tcp"
    to_port         = "80"
    security_groups = [aws_security_group.nia_gp2gp_dmz.id]
  }

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
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
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
    description     = "Allow HTTP traffic from only the pubic sg"
    from_port       = "5671"
    protocol        = "tcp"
    to_port         = "5671"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"] //todo restrict traffic to mq properly
  }

  egress {
    //allow all
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
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
    description     = "Allow HTTP traffic from only the pubic sg"
    from_port       = "5432"
    protocol        = "tcp"
    to_port         = "5432"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"] //todo restrict traffic to mq properly
  }

  egress {
    //allow all
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
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

resource "aws_lb_target_group" "nia_gp2gp_target_group" {
  target_type  = "ip"
  port = 80
  protocol = "TCP"
  vpc_id = aws_vpc.nia_gp2gp_vpc.id

  health_check {
    enabled = true
    interval = 300
    path = "/"
    matcher = "200-599"
  }
}

resource "aws_lb" "nia_gp2gp_elb" {
  name            = "nia-gp2gp-elb"
  subnets         = [for subnet in aws_subnet.nia_gp2gp_public_subnet : subnet.id]
  load_balancer_type = "network"

  tags = {
    Name = "nia_gp2gp-elb"
  }
}

resource "aws_lb_listener" "inbound" {
  load_balancer_arn = aws_lb.nia_gp2gp_elb.arn
  port           = var.http_server_port
  protocol       = "TCP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nia_gp2gp_target_group.arn
  }
}

## ECS Module ##

resource "aws_ecs_cluster" "nia_gp2gp_cluster" {
  name = "gp2gp-ps-chain"
}