############################# AWS Target Group #############################
# This resource defines an AWS Target Group for the staging environment.
# The target group listens on port 80 and uses HTTP protocol.
# It includes a health check configuration with a healthy threshold of 2 and an interval of 10 seconds.
resource "aws_lb_target_group" "staging_tg" {
  name     = "${var.env}-tg-80"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc.id
  health_check {
    healthy_threshold = 2
    interval          = 10
  }
}

############################# AWS Load Balancer #############################
# This resource defines an AWS Application Load Balancer (ALB) for the staging environment.
# The ALB is external (not internal), uses a security group, and is associated with public subnets.
# It also includes tags for name and environment.
resource "aws_lb" "staging_alb" {
  name               = "${var.env}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.public_sg.id]
  subnets            = [for subnet in aws_subnet.public : subnet.id]
  tags = {
    name        = "${var.env}-alb"
    Environment = var.env
  }
}

################ Provides a Load Balancer Listener resource. ################
# This resource defines an HTTPS listener for the ALB.
# It listens on the port and protocol specified by variables, uses an SSL policy, and a certificate.
# The default action forwards traffic to the staging target group.
resource "aws_lb_listener" "staging_https" {
  load_balancer_arn = aws_lb.staging_alb.arn
  port              = var.alb_port_https
  protocol          = var.alb_proto_https
  ssl_policy        = var.alb_sss_profile
  certificate_arn   = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.staging_tg.arn
  }
}

# This resource defines an HTTP listener for the ALB.
# It listens on the port and protocol specified by variables.
# The default action redirects HTTP traffic to HTTPS with a 301 status code.
resource "aws_lb_listener" "staging_http_https" {
  load_balancer_arn = aws_lb.staging_alb.arn
  port              = var.alb_port_http
  protocol          = var.alb_proto_http

  default_action {
    type = "redirect"

    redirect {
      port        = var.alb_port_https
      protocol    = var.alb_proto_https
      status_code = "HTTP_301"
    }
  }
}

# This resource defines a listener rule for the HTTPS listener.
# It forwards traffic to the staging target group if the host header matches specified values.
resource "aws_lb_listener_rule" "staging_web_rule" {
  listener_arn = aws_lb_listener.staging_https.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.staging_tg.arn
  }

  condition {
    host_header {
      values = ["staging.segantlabs.com", "www.staging.segantlabs.com"]
    }
  }
}