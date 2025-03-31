resource "aws_ecr_repository" "angular" {
  name = "winderosion-angular-repo"

  image_scanning_configuration {
    scan_on_push = true
  }

  lifecycle {
    prevent_destroy = true
  }

  tags = {
    Name      = "winderosion-angular-ecr"
    Project   = "winderosion-angular"
    ManagedBy = "Terraform"
  }
}

output "ecr_repository_url" {
  description = "ECR repository URL for pushing Angular frontend Docker images"
  value       = aws_ecr_repository.angular.repository_url
}
