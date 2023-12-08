locals {
  ports = [80, 443, 8080]
}

resource "aws_security_group" "application_elb_sg" {
  vpc_id = aws_vpc.main.id
  name   = "application_elb_sg"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = var.resource_tags
}

resource "aws_security_group_rule" "application_elb_sg_ingress" {
  count             = length(var.elb_sg_ingress_ports)
  type              = "ingress"
  from_port         = var.elb_sg_ingress_ports[count.index]
  to_port           = var.elb_sg_ingress_ports[count.index]
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.application_elb_sg.id
} 

resource "aws_security_group" "ecs_tasks_sg" {
  name        = "ecs-tasks-security-group"
  description = "allow inbound access from the ALB only"
  vpc_id      = aws_vpc.main.id

  dynamic "ingress" {
    for_each = local.ports 
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      security_groups = [aws_security_group.application_elb_sg.id]
    }
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = var.resource_tags
}

resource "aws_security_group" "application_elb_internal_sg" {
  vpc_id = aws_vpc.main.id
  name   = "application_elb_internal_sg"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = var.resource_tags
}

resource "aws_security_group_rule" "application_elb_internal_sg_ingress" {
  count             = length(var.elb_sg_ingress_ports)
  type              = "ingress"
  from_port         = var.elb_sg_ingress_ports[count.index]
  to_port           = var.elb_sg_ingress_ports[count.index]
  protocol          = "tcp"
  cidr_blocks = [aws_vpc.main.cidr_block]
  //source_security_group_id = aws_security_group.ecs_tasks_sg.id
  security_group_id = aws_security_group.application_elb_internal_sg.id
} 

resource "aws_security_group" "ecs_backend_tasks_sg" {
  name        = "ecs-backend-tasks-security-group"
  description = "allow inbound access from the internal ALB only"
  vpc_id      = aws_vpc.main.id

  dynamic "ingress" {
    for_each = local.ports 
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      security_groups = [aws_security_group.application_elb_internal_sg.id]
    }
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = var.resource_tags
}

resource "aws_security_group" "ecr_endpoint_vpce_sg" {
  name   = "ecr-endpoint-vpce-security-group"
  vpc_id = aws_vpc.main.id

  ingress {
    protocol        = "tcp"
    from_port       = 0
    to_port         = 65535
    cidr_blocks     = [aws_vpc.main.cidr_block]
  }
  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = var.resource_tags
}

resource "aws_security_group" "cohort_demo_efs_sg" {
  depends_on = [
    aws_security_group.ecs_tasks_sg,
  ]
  name        = "cohort_demo_efs_security_group"
  description = "Security group for efs storage"
  vpc_id      = aws_vpc.main.id
  
  ingress {
    protocol        = "tcp"
    from_port       = 2049
    to_port         = 2049
    security_groups = [aws_security_group.ecs_tasks_sg.id, aws_security_group.ecs_backend_tasks_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.resource_tags
}

