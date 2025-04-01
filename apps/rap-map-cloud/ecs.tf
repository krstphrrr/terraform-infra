resource "aws_iam_role" "ecs_task_execution_role" {
  name = "rapmap-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_policy" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}
resource "aws_ecs_cluster" "rapmap" {
  name = "rapmap-cluster"
  tags = {
    Name      = "rapmap-cluster"
    Project   = "rapmap-cloud"
    ManagedBy = "Terraform"
  }
  tags_all = {
    Name      = "rapmap-cluster"
    Project   = "rapmap-cloud"
    ManagedBy = "Terraform"
  }
}

resource "aws_ecs_task_definition" "rapmap" {
  family                   = "rapmap-task"
  requires_compatibilities = ["FARGATE"]
  network_mode            = "awsvpc"
  cpu                     = "256"
  memory                  = "512"
  execution_role_arn = aws_iam_role.ecs_task_execution_role.arn


  container_definitions = jsonencode([
    {
      name      = "rapmap"
      image     = "${aws_ecr_repository.rapmap.repository_url}:latest"
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]
    }
  ])

}

resource "aws_ecs_service" "rapmap" {
  name            = "rapmap-service"
  cluster         = module.network.ecs_cluster_arn 
  task_definition = aws_ecs_task_definition.rapmap.arn
  launch_type     = "FARGATE"
  desired_count   = 1

  load_balancer {
    target_group_arn = aws_lb_target_group.rapmap.arn
    container_name   = "rapmap"
    container_port   = 80
    }

    network_configuration {
        subnets          = module.network.subnet_ids
        security_groups  = [module.network.security_group_id]
        assign_public_ip = true
    }
}
