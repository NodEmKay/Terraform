# modules/alb/main.tf

resource "aws_lb" "web_lb" {
  name               = var.lb_name
  internal           = false
  load_balancer_type = "application"
  subnets            = var.subnet_ids
  security_groups    = [var.sg_id]
  depends_on         = [var.instance_ids]
  tags = {
    Name = var.lb_name
  }
}

resource "aws_lb_target_group" "web_tg" {
  name     = var.tg_name
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
  tags = {
    Name = var.tg_name
  }
}

resource "aws_lb_listener" "web_listener" {
  load_balancer_arn = aws_lb.web_lb.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_tg.arn
  }
}

resource "aws_lb_target_group_attachment" "web_attach" {
  count            = length(var.instance_ids)
  target_group_arn = aws_lb_target_group.web_tg.arn
  target_id        = var.instance_ids[count.index]
  port             = 80
}

output "lb_dns" {
  value = aws_lb.web_lb.dns_name
}
