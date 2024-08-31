# main.tf

# Target Group
resource "aws_lb_target_group" "tg_splitwave_lab" {
  name        = var.target_group_name
  vpc_id      = var.vpc_id
  protocol    = "HTTP"
  port        = 80
  target_type = "ip"
  health_check {
    protocol            = "HTTP"
    path                = "/health"
    port                = "8080"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 3
    matcher             = "200-299,301,302"
  }

  tags = {
    Name        = var.target_group_name
    descricao   = "Target group for ECS tasks"
    ambiente    = "lab"
    regiao      = "us-east-1"
    owner       = "luiz.albuquerque.sw"
    owner_dev   = "nilson.sierota.sw"
    owner_infra = "thiago.magalhaes.sw"
  }
}

# Application Load Balancer
resource "aws_lb" "alb_splitwave_lab" {
  name               = var.alb_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.security_group_ids
  subnets            = var.subnet_ids
  ip_address_type    = "ipv4"
  enable_cross_zone_load_balancing = true

  idle_timeout = 300  # 5 minutes
  enable_http2 = true

  tags = {
    Name        = var.alb_name
    descricao   = "Application Load Balancer for splitwave lab"
    ambiente    = "lab"
    regiao      = "us-east-1"
    owner       = "luiz.albuquerque.sw"
    owner_dev   = "nilson.sierota.sw"
    owner_infra = "thiago.magalhaes.sw"
  }
}

# Listener for HTTPS (port 443)
resource "aws_lb_listener" "https_listener" {
  load_balancer_arn = aws_lb.alb_splitwave_lab.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.acm_certificate_arn

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.tg_splitwave_lab.arn
  }

  tags = {
    Name        = "https-listener"
    descricao   = "HTTPS listener for ALB"
    ambiente    = "lab"
    regiao      = "us-east-1"
    owner       = "luiz.albuquerque.sw"
    owner_dev   = "nilson.sierota.sw"
    owner_infra = "thiago.magalhaes.sw"
  }
}

# Listener for HTTP (port 80)
resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.alb_splitwave_lab.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"
    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }

  tags = {
    Name        = "http-listener"
    descricao   = "HTTP listener for ALB with redirect to HTTPS"
    ambiente    = "lab"
    regiao      = "us-east-1"
    owner       = "luiz.albuquerque.sw"
    owner_dev   = "nilson.sierota.sw"
    owner_infra = "thiago.magalhaes.sw"
  }
}
