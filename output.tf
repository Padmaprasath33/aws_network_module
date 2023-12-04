output "vpc_cidr_block" {
  value = aws_vpc.main.cidr_block
}

output "aws_subnet_public" {
  value = aws_subnet.public_subnet.id
}

output "aws_subnet_private" {
  value = aws_subnet.private_subnet.id
}