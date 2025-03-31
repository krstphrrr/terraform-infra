resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name      = "${var.project_name}-vpc"
    Project   = var.project_name
    ManagedBy = "Terraform"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name      = "${var.project_name}-igw"
    Project   = var.project_name
    ManagedBy = "Terraform"
  }
}

resource "aws_subnet" "public_a" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidr
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = true

  tags = {
    Name      = "${var.project_name}-subnet-a"
    Project   = var.project_name
    ManagedBy = "Terraform"
  }
}

resource "aws_subnet" "public_b" {
  count = var.public_subnet_cidr_b != null && var.availability_zone_b != null ? 1 : 0

  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidr_b
  availability_zone       = var.availability_zone_b
  map_public_ip_on_launch = true

  tags = {
    Name      = "${var.project_name}-subnet-b"
    Project   = var.project_name
    ManagedBy = "Terraform"
  }
}


resource "aws_route_table_association" "public_b" {
  count          = var.public_subnet_cidr_b != null && var.availability_zone_b != null ? 1 : 0
  subnet_id      = aws_subnet.public_b[0].id
  route_table_id = aws_route_table.public.id
}


resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name      = "${var.project_name}-route-table"
    Project   = var.project_name
    ManagedBy = "Terraform"
  }
}

resource "aws_route_table_association" "public_a" {
  subnet_id      = aws_subnet.public_a.id
  route_table_id = aws_route_table.public.id
}

resource "aws_security_group" "ecs_sg" {
  name        = "${var.project_name}-sg"
#   description = "Security group for ${var.project_name}"
    description = "Allow inbound access to port 8080"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = var.ingress_port
    to_port     = var.ingress_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name      = "${var.project_name}-sg"
    Project   = var.project_name
    ManagedBy = "Terraform"
  }
}

resource "aws_ecs_cluster" "cluster" {
  name = "${var.project_name}-cluster"

  tags = {
    Name      = "${var.project_name}-cluster"
    Project   = var.project_name
    ManagedBy = "Terraform"
  }
}
