output "vpc_cidr_block" {
  value = aws_vpc.main.cidr_block
}

output "vpc_id" {
  value = aws_vpc.main.id
}

output "aws_subnet_public" {
  value = aws_subnet.public_subnet[*].id
}

output "aws_subnet_private" {
  value = aws_subnet.private_subnet[*].id
}

output "alb_sg_id" {
  value = aws_security_group.alb_sg.id
}

output "ecs_tasks_sg_id" {
  value = aws_security_group.ecs_tasks_sg.id
}

output "ecr_endpoint_vpce_sg_id" {
  value = aws_security_group.ecr_endpoint_vpce_sg.id
}

output "application_elb_sg" {
  value = aws_security_group.application_elb_sg.id
}

output "cohort_demo_efs_sg" {
  value = aws_security_group.cohort_demo_efs_sg.id
}