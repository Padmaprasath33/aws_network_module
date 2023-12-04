resource "aws_vpc_endpoint" "s3_endpoint" {
  vpc_id       = aws_vpc.main.id
  service_name = var.s3_endpoint_service_name
}

resource "aws_vpc_endpoint_route_table_association" "s3_endpoint_route_table_association" {
  count          = var.az_count
  route_table_id = element(aws_route_table.private_route_table.*.id, count.index)
  vpc_endpoint_id = aws_vpc_endpoint.s3_endpoint.id
}

resource "aws_vpc_endpoint" "dynamodb_endpoint" {
  vpc_id       = aws_vpc.main.id
  service_name = var.dynamodb_endpoint_service_name
}

resource "aws_vpc_endpoint_route_table_association" "dynamodb_endpoint_route_table_association" {
  count          = var.az_count
  route_table_id = element(aws_route_table.private_route_table.*.id, count.index)
  vpc_endpoint_id = aws_vpc_endpoint.dynamodb_endpoint.id
}

resource "aws_vpc_endpoint" "ecr_dkr_endpoint" {
  vpc_id            = aws_vpc.main.id
  service_name      = var.ecr_dkr_endpoint_service_name
  vpc_endpoint_type = "Interface"

  security_group_ids = [
    aws_security_group.ecr_endpoint_vpce_sg.id,
  ]

  count          = var.az_count
  subnet_ids      = element(aws_subnet.private_subnet.*.id, count.index)
  private_dns_enabled = true
}

resource "aws_vpc_endpoint" "ecr_api_endpoint" {
  vpc_id            = aws_vpc.main.id
  service_name      = var.ecr_api_endpoint_service_name
  vpc_endpoint_type = "Interface"

  security_group_ids = [
    aws_security_group.ecr_endpoint_vpce_sg.id,
  ]

  count          = var.az_count
  subnet_ids      = element(aws_subnet.private_subnet.*.id, count.index)
  private_dns_enabled = true
}

resource "aws_vpc_endpoint" "ecr_logs_endpoint" {
  vpc_id            = aws_vpc.main.id
  service_name      = var.ecr_logs_endpoint_service_name
  vpc_endpoint_type = "Interface"

  security_group_ids = [
    aws_security_group.ecr_endpoint_vpce_sg.id,
  ]

  count          = var.az_count
  subnet_ids      = element(aws_subnet.private_subnet.*.id, count.index)
  private_dns_enabled = true
}