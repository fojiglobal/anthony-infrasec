############################# AWS Target Group #############################
resource "aws_lb_target_group" "staging_tg" {
  name     = "${var.staging_env}-tg-80"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.staging.id
  health_check {
    healthy_threshold = 2
    interval          = 10
  }
}
############################# AWS Load Balancer #############################
resource "aws_lb" "staging_alb" {
  name               = "${var.staging_env}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.pub_sg.id]
  subnets            = [aws_subnet.staging_pub_1.id, aws_subnet.staging_pub_2.id]
  tags = {
    name        = "${var.staging_env}-alb"
    Environment = var.staging_env
  }
}

################ Provides a Load Balancer Listener resource. ################

resource "aws_lb_listener" "staging_https" {
  load_balancer_arn = aws_lb.staging_alb.arn
  port              = var.alb_port_https
  protocol          = var.alb_proto_https
  ssl_policy        = var.alb_sss_profile
  certificate_arn   = data.aws_acm_certificate.alb_cert.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.staging_tg.arn
  }
}

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