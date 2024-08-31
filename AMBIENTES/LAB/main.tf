# main.tf

module "network" {
  source  = "./modules/network"
  vpc_cidr = "172.25.0.0/23"
  vpc_name = "vpc-splitwave-lab"
}

module "database" {
  source              = "./modules/database"
  secret_name         = "db-splitwave-asm-lab"
  db_identifier       = "db-lab-splitwave"
  engine              = "aurora-postgresql"
  db_version          = "14.9"
  instance_class      = "db.r5.large"
  master_username     = "admin_api"
  db_subnet_ids       = module.network.db_subnet_ids
  security_group_ids  = [module.network.rds_security_group_id]
  instance_count      = 1
}

module "alb" {
  source              = "./modules/alb"
  vpc_id              = "vpc-0c2ada97b541ff6d8"
  subnet_ids          = ["subnet-07c8765a956dfd776", "subnet-06a75f3abcc4460c4"]
  security_group_ids  = ["sg-02b331025d87924cb"]
  alb_name            = "alb-splitwave-lab"
  target_group_name   = "tg-splitwave-lab"
  acm_certificate_arn = "arn:aws:acm:us-east-1:615299742468:certificate/0ab2ede2-6acd-451d-b43a-cc8559ce9af6"
}

module "ecs" {
  source              = "./modules/ecs"
  cluster_name        = "splitwave-lab-cluster"
  task_family         = "splitwave-lab-task"
  container_name      = "splitwave-lab-container"
  container_image     = "615299742468.dkr.ecr.us-east-1.amazonaws.com/splitwave-lab:latest"
  task_role           = "arn:aws:iam::615299742468:role/splitwave-lab-ecs-task-assume-role"
  task_execution_role = "arn:aws:iam::615299742468:role/splitwave-lab-ecs-task-assume-role"
  log_group           = "splitwave-lab-container-log"
  log_stream_prefix   = "splitwave-lab-container"
  aws_region          = "us-east-1"
  subnet_ids          = ["subnet-028960a944ce2abd5", "subnet-07288a502e551950c"]
  security_group_ids  = ["sg-0dbf5f9305c9f2428"]
  target_group_arn    = module.alb.target_group_arn
  service_name        = "splitwave-lab-service"
  desired_count       = 1
}