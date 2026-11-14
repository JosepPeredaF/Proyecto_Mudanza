resource "aws_ecs_task_definition" "worker_gps" {
  family                   = "${var.project}-${var.environment}-worker-gps"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = aws_iam_role.ecs_task_execution.arn

  container_definitions = jsonencode([
    {
      name                   = "api-web"
      image                  = "${aws_ecr_repository.app.repository_url}:latest"
      essential              = true
      readonlyRootFilesystem = true
      portMappings           = [{ containerPort = 80, protocol = "tcp" }]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = aws_cloudwatch_log_group.api_web.name
          "awslogs-region"        = var.aws_region
          "awslogs-stream-prefix" = "api-web"
        }
      }
    }
  ])
}

resource "aws_ecs_service" "worker_gps" {
  name            = "worker-gps"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.worker_gps.arn
  desired_count   = 2
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = aws_subnet.private_app[*].id
    security_groups  = [aws_security_group.worker_gps.id]
    assign_public_ip = false
  }
}