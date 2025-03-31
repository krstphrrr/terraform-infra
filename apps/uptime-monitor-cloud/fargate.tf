resource "aws_ecs_service" "uptime_monitor" {
  name            = "uptime-monitor-service"
  cluster         = module.network.ecs_cluster_arn
  launch_type     = "FARGATE"
  task_definition = aws_ecs_task_definition.uptime_monitor.arn
  desired_count   = 1

  network_configuration {
    subnets          = [module.network.subnet_id]
    security_groups  = [module.network.security_group_id]
    assign_public_ip = true
  }

  deployment_minimum_healthy_percent = 100
  deployment_maximum_percent         = 200

  tags = {
    Name = "uptime-monitor-ecs-service"
    Project = "uptime-monitor"
    ManagedBy = "Terraform"
  }
}