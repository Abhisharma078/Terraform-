data "aws_vpc" "default" {
    default = true
}

data "aws_subnets" "defaults" {
    filter {
        name = "vpc-id"
        values = [data.aws_vpc.default.id]
    }
}

resource "aws_security_group" "sg" {
    name = "sg"
    description = "sg"
    vpc_id = data.aws_vpc.default.id

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        Name = "sg"
    }
}

resource "aws_lb_target_group" "tg" {
  name = "tg"
  port = 80
  protocol = "http"
  vpc_id = data.aws_vpc.default.id
  health_check {
    path = "/"
  }
  tags = {
    Name = "tg"
  }
}

resource "aws_lb" "lb" {
  name = "lb"
    load_balancer_type = "application"
    subnets = data.aws_subnets.defaults.ids
    internal = false
    security_groups = [aws_security_group.sg.id]

    tags = {
      Name = "lb"
    }
}

resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.lb.arn
  port = 80
  protocol = "http"
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
    }
  }

resource "aws_launch_template" "lt" {
    name_prefix = "web-lt"
  image_id = "ami-02167eae61967e403"
    key_name = "ubuntu"
    instance_type = "t3.micro"
    vpc_security_group_ids = [aws_security_group.sg.id]

    user_data = filebase64("/root/Terraform-/day-4/user_data.sh")
}

  resource "aws_autoscaling_group" "asg" {
     name = "asg"
     desired_capacity = 2
     min_size = 2
     max_size = 5
     target_group_arns = [aws_lb_target_group.tg.arn]
     vpc_zone_identifier =  data.aws_subnets.defaults.ids
     launch_template {
       id = aws_launch_template.lt.id
       version = "$Latest"
     }
     health_check_type = "ELB"
  }



