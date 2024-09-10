# main.tf

module "network" {
  source  = "./modules/network"
  vpc_cidr = "172.25.0.0/23"
  vpc_name = "vpc-splitwave-lab"
}

module "database" {
  source              = "./modules/database"
  secret_name         = "db-splitwave-asm-lab03"
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
  vpc_id              = "vpc-0add89122b781ef6e"
  subnet_ids          = ["subnet-045c9e49d3bffe1ff", "subnet-0d8ccefcc3f5781b7"]
  security_group_ids  = ["sg-02817a9e789c9a512"]
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
  subnet_ids          = ["subnet-0bc12bbc7cf0fddf0", "subnet-0f8e609e3d8b19fd0"]
  security_group_ids  = ["sg-087c96b237dbf22c0"]
  target_group_arn    = module.alb.target_group_arn
  service_name        = "splitwave-lab-service"
  desired_count       = 1
}