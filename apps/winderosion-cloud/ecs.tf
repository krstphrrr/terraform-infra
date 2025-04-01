resource "aws_iam_role" "ecs_task_execution_role" {
  name = "angular-execution-role"

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
resource "aws_ecs_cluster" "angular" {
  name = "winderosion-angular-cluster"
  tags = {
    Name      = "winderosion-angular-cluster"
    Project   = "winderosion-angular"
    ManagedBy = "Terraform"
  }
  tags_all = {
    Name      = "winderosion-angular-cluster"
    Project   = "winderosion-angular"
    ManagedBy = "Terraform"
  }
}

resource "aws_ecs_task_definition" "angular" {
  family                   = "winderosion-angular-task"
  requires_compatibilities = ["FARGATE"]
  network_mode            = "awsvpc"
  cpu                     = "256"
  memory                  = "512"
  execution_role_arn = aws_iam_role.ecs_task_execution_role.arn


  container_definitions = jsonencode([
    {
      name      = "angular"
      image     = "${aws_ecr_repository.angular.repository_url}:latest"
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

resource "aws_ecs_service" "angular" {
  name            = "winderosion-angular-service"
  cluster         = module.network.ecs_cluster_arn 
  task_definition = aws_ecs_task_definition.angular.arn
  launch_type     = "FARGATE"
  desired_count   = 1

  load_balancer {
    target_group_arn = aws_lb_target_group.angular.arn
    container_name   = "angular"
    container_port   = 80
    }

    network_configuration {
        subnets          = module.network.subnet_ids
        security_groups  = [module.network.security_group_id]
        assign_public_ip = true
    }
}
