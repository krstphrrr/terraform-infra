output "vpc_id" {
  value = aws_vpc.main.id
}

output "subnet_id" {
  value = aws_subnet.public_a.id
}

output "security_group_id" {
  value = aws_security_group.ecs_sg.id
}

output "ecs_cluster_name" {
  value = aws_ecs_cluster.cluster.name
}

output "ecs_cluster_arn" {
  value = aws_ecs_cluster.cluster.arn
}

output "subnet_ids" {
  value = compact([
    aws_subnet.public_a.id,
    length(aws_subnet.public_b) > 0 ? aws_subnet.public_b[0].id : null
  ])
}