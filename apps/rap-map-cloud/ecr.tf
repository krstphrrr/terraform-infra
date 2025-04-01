resource "aws_ecr_repository" "rapmap" {
  name = "rapmap-cloud-ecr"

  image_scanning_configuration {
    scan_on_push = true
  }

  force_delete = true

  # lifecycle {
    # prevent_destroy = true
  # }


  tags = {
    Name      = "rapmap-ecr"
    Project   = "rapmap-cloud"
    ManagedBy = "Terraform"
  }
}

output "ecr_repository_url" {
  description = "ECR repository URL for pushing Angular frontend Docker images"
  value       = aws_ecr_repository.rapmap.repository_url
}
