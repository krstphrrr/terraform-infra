resource "aws_lb" "rapmap" {
  name               = "rapmap-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [module.network.security_group_id]
  subnets            = module.network.subnet_ids


  tags = {
    Name = "rapmap-alb"
  }
}

resource "aws_lb_target_group" "rapmap" {
  name        = "angular-target-group"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = module.network.vpc_id

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200-399"
  }

  tags = {
    Name = "angular-target-group"
  }
}

resource "aws_lb_listener" "rapmap" {
  load_balancer_arn = aws_lb.rapmap.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.rapmap.arn
  }
}
