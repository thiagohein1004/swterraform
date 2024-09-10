# main.tf

# VPC
resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  instance_tenancy     = "default"

  tags = {
    Name        = var.vpc_name
    descricao   = "vpc_desenvolvimento_splitwave"
    ambiente    = "dev"
    regiao      = "us-east-1"
    owner       = "luiz.albuquerque.sw"
    owner_dev   = "nilson.sierota.sw"
    owner_infra = "thiago.magalhaes.sw" 
  }
}

# Subnets
resource "aws_subnet" "public_aza" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = "10.20.0.224/27"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "subnet-splitwave-pub-dev-aza"
    descricao   = "subnet_dev_splitwave_publica_zona_a"
    ambiente    = "dev"
    regiao      = "us-east-1"
    owner       = "luiz.albuquerque.sw"
    owner_dev   = "nilson.sierota.sw"
    owner_infra = "thiago.magalhaes.sw" 
  }
}

resource "aws_subnet" "public_azb" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = "10.20.0.192/27"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "subnet-splitwave-pub-dev-azb"
    descricao   = "subnet_dev_splitwave_publica_zona_b"
    ambiente    = "dev"
    regiao      = "us-east-1"
    owner       = "luiz.albuquerque.sw"
    owner_dev   = "nilson.sierota.sw"
    owner_infra = "thiago.magalhaes.sw" 
  }
}

resource "aws_subnet" "db_aza" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = "10.20.0.0/27"
  availability_zone = "us-east-1a"

  tags = {
    Name = "subnet-splitwave-db-dev-aza"
    descricao   = "subnet_dev_splitwave_database_zona_a"
    ambiente    = "dev"
    regiao      = "us-east-1"
    owner       = "luiz.albuquerque.sw"
    owner_dev   = "nilson.sierota.sw"
    owner_infra = "thiago.magalhaes.sw" 
  }
}

resource "aws_subnet" "db_azb" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = "10.20.0.32/27"
  availability_zone = "us-east-1b"

  tags = {
    Name = "subnet-splitwave-db-dev-azb"
    descricao   = "subnet_dev_splitwave_database_zona_b"
    ambiente    = "dev"
    regiao      = "us-east-1"
    owner       = "luiz.albuquerque.sw"
    owner_dev   = "nilson.sierota.sw"
    owner_infra = "thiago.magalhaes.sw" 
  }
}

resource "aws_subnet" "private_aza" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = "10.20.1.128/25"
  availability_zone = "us-east-1a"

  tags = {
    Name = "subnet-splitwave-priv-dev-aza"
    descricao   = "subnet_dev_splitwave_privada_zona_a"
    ambiente    = "dev"
    regiao      = "us-east-1"
    owner       = "luiz.albuquerque.sw"
    owner_dev   = "nilson.sierota.sw"
    owner_infra = "thiago.magalhaes.sw" 
  }
}

resource "aws_subnet" "private_azb" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = "10.20.0.160/27"
  availability_zone = "us-east-1b"

  tags = {
    Name = "subnet-splitwave-priv-dev-azb"
    descricao   = "subnet_dev_splitwave_privada_zona_b"
    ambiente    = "dev"
    regiao      = "us-east-1"
    owner       = "luiz.albuquerque.sw"
    owner_dev   = "nilson.sierota.sw"
    owner_infra = "thiago.magalhaes.sw" 
  }
}

# Internet Gateway
resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "IGW-SPLITWAVE-DEV"
    descricao   = "internet_gateway_dev_splitwave"
    ambiente    = "dev"
    regiao      = "us-east-1"
    owner       = "luiz.albuquerque.sw"
    owner_dev   = "nilson.sierota.sw"
    owner_infra = "thiago.magalhaes.sw" 
  }
}

# Elastic IPs for NAT Gateways
resource "aws_eip" "eip_aza" {
  vpc = true

  tags = {
    Name = "pip-splitwave-dev-aza"
    descricao   = "pip_dev_splitwave_zona_a"
    ambiente    = "dev"
    regiao      = "us-east-1"
    owner       = "luiz.albuquerque.sw"
    owner_dev   = "nilson.sierota.sw"
    owner_infra = "thiago.magalhaes.sw" 
  }
}

resource "aws_eip" "eip_azb" {
  vpc = true

  tags = {
    Name = "pip-splitwave-dev-azb"
    descricao   = "pip_dev_splitwave_zona_b"
    ambiente    = "dev"
    regiao      = "us-east-1"
    owner       = "luiz.albuquerque.sw"
    owner_dev   = "nilson.sierota.sw"
    owner_infra = "thiago.magalhaes.sw" 
  }
}

# NAT Gateways
resource "aws_nat_gateway" "nat_aza" {
  allocation_id = aws_eip.eip_aza.id
  subnet_id     = aws_subnet.public_aza.id

  tags = {
    Name = "nat-gw-splitwave-dev-aza"
    descricao   = "natgateway_dev_splitwave_zona_a"
    ambiente    = "dev"
    regiao      = "us-east-1"
    owner       = "luiz.albuquerque.sw"
    owner_dev   = "nilson.sierota.sw"
    owner_infra = "thiago.magalhaes.sw" 
  }
}

resource "aws_nat_gateway" "nat_azb" {
  allocation_id = aws_eip.eip_azb.id
  subnet_id     = aws_subnet.public_azb.id

  tags = {
    Name = "nat-gw-splitwave-dev-azb"
    descricao   = "natgateway_dev_splitwave_zona_b"
    ambiente    = "dev"
    regiao      = "us-east-1"
    owner       = "luiz.albuquerque.sw"
    owner_dev   = "nilson.sierota.sw"
    owner_infra = "thiago.magalhaes.sw" 
  }
}

# Route Tables and Associations
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = {
    Name = "route-splitwave-dev-pub"
    descricao   = "routetable_dev_splitwave_publica"
    ambiente    = "dev"
    regiao      = "us-east-1"
    owner       = "luiz.albuquerque.sw"
    owner_dev   = "nilson.sierota.sw"
    owner_infra = "thiago.magalhaes.sw" 
  }
}

resource "aws_route_table_association" "public_aza" {
  subnet_id      = aws_subnet.public_aza.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_azb" {
  subnet_id      = aws_subnet.public_azb.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table" "private_aza" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_aza.id
  }

  tags = {
    Name = "route-splitwave-priv-dev-aza"
    descricao   = "routetable_dev_splitwave_privada_zona_a"
    ambiente    = "dev"
    regiao      = "us-east-1"
    owner       = "luiz.albuquerque.sw"
    owner_dev   = "nilson.sierota.sw"
    owner_infra = "thiago.magalhaes.sw" 
  }
}

resource "aws_route_table_association" "private_aza_association" {
  subnet_id      = aws_subnet.private_aza.id
  route_table_id = aws_route_table.private_aza.id
}

resource "aws_route_table" "private_azb" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_azb.id
  }

  tags = {
    Name = "route-splitwave-priv-dev-azb"
    descricao   = "routetable_dev_splitwave_privada_zona_b"
    ambiente    = "dev"
    regiao      = "us-east-1"
    owner       = "luiz.albuquerque.sw"
    owner_dev   = "nilson.sierota.sw"
    owner_infra = "thiago.magalhaes.sw" 
  }
}

resource "aws_route_table_association" "private_azb_association" {
  subnet_id      = aws_subnet.private_azb.id
  route_table_id = aws_route_table.private_azb.id
}

resource "aws_route_table" "db_aza" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_aza.id
  }

  tags = {
    Name = "route-splitwave-db-dev-aza"
    descricao   = "routetable_dev_splitwave_database_zona_a"
    ambiente    = "dev"
    regiao      = "us-east-1"
    owner       = "luiz.albuquerque.sw"
    owner_dev   = "nilson.sierota.sw"
    owner_infra = "thiago.magalhaes.sw" 
  }
}

resource "aws_route_table_association" "db_aza_association" {
  subnet_id      = aws_subnet.db_aza.id
  route_table_id = aws_route_table.db_aza.id
}

resource "aws_route_table" "db_azb" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_azb.id
  }

  tags = {
    Name = "route-splitwave-db-dev-azb"
    descricao   = "routetable_dev_splitwave_database_zona_b"
    ambiente    = "dev"
    regiao      = "us-east-1"
    owner       = "luiz.albuquerque.sw"
    owner_dev   = "nilson.sierota.sw"
    owner_infra = "thiago.magalhaes.sw" 
  }
}

resource "aws_route_table_association" "db_azb_association" {
  subnet_id      = aws_subnet.db_azb.id
  route_table_id = aws_route_table.db_azb.id
}

# Security Groups
resource "aws_security_group" "ecs" {
  name        = "sg_splitwave_dev_ecs"
  description = "ECS Security Group DEV"
  vpc_id      = aws_vpc.this.id

  ingress {
    description      = "HTTPS ingress"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sg-splitwave-dev-ecs"
  }
}

resource "aws_security_group" "alb" {
  name        = "sg_splitwave_dev_alb"
  description = "ALB Security Group"
  vpc_id      = aws_vpc.this.id

  ingress {
    description      = "HTTPS ingress"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sg-splitwave-dev-alb"
  }
}

resource "aws_security_group" "rds" {
  name        = "sg_splitwave_dev_rds"
  description = "RDS Security Group"
  vpc_id      = aws_vpc.this.id

  ingress {
    description      = "PostgreSQL ingress Nilson"
    from_port        = 5432
    to_port          = 5432
    protocol         = "tcp"
    cidr_blocks      = ["192.5.72.102/32"]
  }

  ingress {
    description      = "PostgreSQL ingress Luiz"
    from_port        = 5432
    to_port          = 5432
    protocol         = "tcp"
    cidr_blocks      = ["168.228.181.125/32"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sg-splitwave-dev-rds"
  }
}

resource "aws_security_group" "amazonmq" {
  name        = "sg_splitwave_dev_amazonmq"
  description = "AmazonMQ Security Group"
  vpc_id      = aws_vpc.this.id

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sg-splitwave-dev-amazonmq"
  }
}
