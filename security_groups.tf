resource "aws_security_group" "alb_sg" {
  name        = "alb-security-group"
  description = "controls access to the ALB"
  vpc_id      = aws_vpc.main.id

  ingress {
    protocol    = "tcp"
    from_port   = var.app_port
    to_port     = var.app_port
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Traffic to the ECS cluster should only come from the ALB
resource "aws_security_group" "ecs_tasks_sg" {
  name        = "ecs-tasks-security-group"
  description = "allow inbound access from the ALB only"
  vpc_id      = aws_vpc.main.id

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
}

resource "aws_security_group" "ecr_endpoint_vpce_sg" {
  name   = "ecr-endpoint-vpce-security-group"
  vpc_id = aws_vpc.main.id
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.main.cidr_block]
  }
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
}

/////////////////////////////////////////////////////////////


resource "aws_security_group" "application_elb_sg" {
  vpc_id = aws_vpc.main.id
  name   = "application_elb_sg"
}

resource "aws_security_group_rule" "application_elb_sg_ingress" {
  count             = length(var.elb_sg_ingress_ports)
  type              = "ingress"
  from_port         = var.elb_sg_ingress_ports[count.index]
  to_port           = var.elb_sg_ingress_ports[count.index]
  protocol          = "tcp"
  cidr_blocks       = [aws_vpc.main.cidr_block]
  security_group_id = aws_security_group.application_elb_sg.id
} 

resource "aws_security_group" "application_elb_internal_sg" {
  vpc_id = aws_vpc.main.id
  name   = "application_elb_internal_sg"
}

resource "aws_security_group_rule" "application_elb_internal_sg_ingress" {
  count             = length(var.elb_sg_ingress_ports)
  type              = "ingress"
  from_port         = var.elb_sg_ingress_ports[count.index]
  to_port           = var.elb_sg_ingress_ports[count.index]
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.application_elb_internal_sg.id
} 

resource "aws_security_group" "cohort_demo_efs_sg" {
  depends_on = [
    aws_security_group.ecs_tasks_sg,
  ]
  name        = "cohort_demo_efs_security_group"
  description = "Security group for efs storage"
  vpc_id      = aws_vpc.main.id
 


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }


  ingress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups = [aws_security_group.ecs_tasks_sg.id]
  }
}

