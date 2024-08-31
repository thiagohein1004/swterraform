# main.tf

# Criação do segredo no AWS Secrets Manager para o banco de dados RDS PostgreSQL
resource "aws_secretsmanager_secret" "db_secret" {
  name        = var.secret_name
  description = "Secret for the RDS PostgreSQL database with identifier ${var.db_identifier}"

  tags = {
    Name        = var.secret_name
    descricao   = "database_lab_splitwave"
    ambiente    = "lab"
    regiao      = "us-east-1"
    owner       = "luiz.albuquerque.sw"
    owner_dev   = "nilson.sierota.sw"
    owner_infra = "thiago.magalhaes.sw"
  }
}

# Definindo a versão do segredo com o nome de usuário e senha
resource "aws_secretsmanager_secret_version" "db_secret_version" {
  secret_id     = aws_secretsmanager_secret.db_secret.id
  secret_string = jsonencode({
    username = "ad_admin",
    password = "WfAFa905t694HC8Kpc"
  })
}

# Criação de uma chave KMS gerenciada pela AWS para criptografia
resource "aws_kms_key" "rds" {
  description             = "KMS key for RDS encryption"
  deletion_window_in_days = 7

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "AWS": "*"
        },
        "Action": "kms:*",
        "Resource": "*"
      }
    ]
  })

  tags = {
    Name = "aws/rds"
  }
}

# Grupo de Sub-redes do banco de dados
resource "aws_db_subnet_group" "this" {
  name       = "db-subnet-group-splitwave"
  subnet_ids = var.db_subnet_ids

  tags = {
    Name = "db-subnet-group-splitwave"
  }
}

# Cluster Aurora PostgreSQL
resource "aws_rds_cluster" "this" {
  cluster_identifier      = var.db_identifier
  engine                  = var.engine
  engine_version          = var.db_version
  database_name           = "splitwave"
  master_username         = var.master_username
  master_password         = jsondecode(aws_secretsmanager_secret_version.db_secret_version.secret_string)["password"]
  db_subnet_group_name    = aws_db_subnet_group.this.name
  vpc_security_group_ids  = var.security_group_ids
  storage_encrypted       = true
  kms_key_id              = aws_kms_key.rds.arn
  deletion_protection     = false
  skip_final_snapshot     = true

  tags = {
    Name        = var.db_identifier
    descricao   = "database_lab_splitwave"
    ambiente    = "lab"
    regiao      = "us-east-1"
    owner       = "luiz.albuquerque.sw"
    owner_dev   = "nilson.sierota.sw"
    owner_infra = "thiago.magalhaes.sw"
  }
}

# Instância do Banco de Dados do Aurora PostgreSQL
resource "aws_rds_cluster_instance" "this" {
  count              = var.instance_count
  identifier         = "${var.db_identifier}-instance-${count.index + 1}"
  cluster_identifier = aws_rds_cluster.this.id
  instance_class     = var.instance_class
  engine             = var.engine

  tags = {
    Name        = "${var.db_identifier}-instance-${count.index + 1}"
    descricao   = "database_lab_splitwave"
    ambiente    = "lab"
    regiao      = "us-east-1"
    owner       = "luiz.albuquerque.sw"
    owner_dev   = "nilson.sierota.sw"
    owner_infra = "thiago.magalhaes.sw"
  }
}
