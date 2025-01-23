resource "aws_lb" "app_lb" {
  name                       = var.name
  load_balancer_type         = "application"
  subnets                    = [for subnet in aws_subnet.public : subnet.id]
  idle_timeout               = 60
  security_groups            = [aws_security_group.custom_sg.id]
  internal                   = false
  enable_deletion_protection = true
  drop_invalid_header_fields = true
}

resource "aws_lb_target_group" "blue_target_group" {
  name        = "${var.name}-blue"
  port        = 8080
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = aws_vpc.this.id
  health_check {
    matcher = "200,301,302,404"
    path    = "/healthcheck"
  }
}

resource "aws_lb_target_group" "green_target_group" {
  name        = "${var.name}-green"
  port        = 8080
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = aws_vpc.this.id
  health_check {
    matcher = "200,301,302,404"
    path    = "/healthcheck"
  }
}

resource "aws_alb_listener" "listener" {
  load_balancer_arn = aws_lb.app_lb.id
  port              = 80
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.blue_target_group.arn
  }
  lifecycle {
    ignore_changes = [default_action]
  }
}