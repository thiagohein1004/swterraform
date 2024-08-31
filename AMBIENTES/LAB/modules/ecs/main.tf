# main.tf

# ECS Cluster
resource "aws_ecs_cluster" "splitwave_lab_cluster" {
  name = var.cluster_name

  tags = {
    Name        = var.cluster_name
    descricao   = "ECS Cluster for splitwave lab"
    ambiente    = "lab"
    regiao      = "us-east-1"
    owner       = "luiz.albuquerque.sw"
    owner_dev   = "nilson.sierota.sw"
    owner_infra = "thiago.magalhaes.sw"
  }
}

# ECS Task Definition
resource "aws_ecs_task_definition" "splitwave_lab_task" {
  family                   = var.task_family
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "1024"  # 1 vCPU
  memory                   = "2048"  # 2 GB
  execution_role_arn       = var.task_execution_role
  task_role_arn            = var.task_role

  container_definitions = jsonencode([
    {
      name      = var.container_name
      image     = var.container_image
      essential = true
      portMappings = [
        {
          containerPort = 8080
          hostPort      = 8080
          protocol      = "tcp"
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = var.log_group
          "awslogs-region"        = var.aws_region
          "awslogs-stream-prefix" = var.log_stream_prefix
        }
      }
      cpu = 1024
      memory = 2048  # hard limit
    }
  ])

  tags = {
    Name        = var.task_family
    descricao   = "ECS Task Definition for splitwave lab"
    ambiente    = "lab"
    regiao      = "us-east-1"
    owner       = "luiz.albuquerque.sw"
    owner_dev   = "nilson.sierota.sw"
    owner_infra = "thiago.magalhaes.sw"
  }
}

# ECS Service
resource "aws_ecs_service" "splitwave_lab_service" {
  name            = var.service_name
  cluster         = aws_ecs_cluster.splitwave_lab_cluster.id
  task_definition = aws_ecs_task_definition.splitwave_lab_task.arn
  desired_count   = var.desired_count
  launch_type     = "FARGATE"
  platform_version = "LATEST"

  network_configuration {
    subnets         = var.subnet_ids
    security_groups = var.security_group_ids
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = var.container_name
    container_port   = 8080
  }

  tags = {
    Name        = var.service_name
    descricao   = "ECS Service for splitwave lab"
    ambiente    = "lab"
    regiao      = "us-east-1"
    owner       = "luiz.albuquerque.sw"
    owner_dev   = "nilson.sierota.sw"
    owner_infra = "thiago.magalhaes.sw"
  }
}
