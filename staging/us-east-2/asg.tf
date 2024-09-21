resource "aws_launch_template" "staging_lt" {
  name                                 = "${var.staging_env}-lt"
  image_id                             = "ami-085f9c64a9b75eed5"
  instance_type                        = "t2.micro"
  instance_initiated_shutdown_behavior = "terminate"
  vpc_security_group_ids               = [aws_security_group.private_sg.id]
  user_data                            = filebase64("web.sh")

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "staging-env-lt"
    }
  }
}

########################### ASG ###############################
resource "aws_autoscaling_group" "staging_asg" {
  name                = "${var.staging_env}-asg"
  vpc_zone_identifier = [aws_subnet.staging_pri_1.id, aws_subnet.staging_pri_2.id]
  desired_capacity    = 2
  max_size            = 2
  min_size            = 1
  target_group_arns   = [aws_lb_target_group.staging_tg.arn]
  launch_template {
    id      = aws_launch_template.staging_lt.id
    version = "$Latest"
  }
  tag {
    key                 = "name"
    value               = "${var.staging_env}-web"
    propagate_at_launch = true
  }
}
