resource "aws_vpc_endpoint" "s3_endpoint" {
  vpc_id       = aws_vpc.main.id
  service_name = "com.amazonaws.${var.region}.s3"
}

resource "aws_vpc_endpoint_route_table_association" "s3_endpoint_route_table_association" {
  count          = var.az_count
  route_table_id = element(aws_route_table.private_route_table.*.id, count.index)
  vpc_endpoint_id = aws_vpc_endpoint.s3_endpoint.id
}

resource "aws_vpc_endpoint" "dynamodb_endpoint" {
  vpc_id       = aws_vpc.main.id
  service_name = "com.amazonaws.${var.region}.dynamodb"
}

resource "aws_vpc_endpoint_route_table_association" "dynamodb_endpoint_route_table_association" {
  count          = var.az_count
  route_table_id = element(aws_route_table.private_route_table.*.id, count.index)
  vpc_endpoint_id = aws_vpc_endpoint.dynamodb_endpoint.id
}

resource "aws_vpc_endpoint" "ecr_dkr_endpoint" {
  vpc_id            = aws_vpc.main.id
  service_name      = "com.amazonaws.${var.region}.ecr.dkr"
  vpc_endpoint_type = "Interface"

  security_group_ids = [
    aws_security_group.ecr_endpoint_vpce_sg.id,
  ]

  subnet_ids      = aws_subnet.private_subnet.*.id
  private_dns_enabled = true
}

resource "aws_vpc_endpoint" "ecr_api_endpoint" {
  vpc_id            = aws_vpc.main.id
  service_name      = "com.amazonaws.${var.region}.ecr.api"
  vpc_endpoint_type = "Interface"

  security_group_ids = [
    aws_security_group.ecr_endpoint_vpce_sg.id,
  ]

  subnet_ids      = aws_subnet.private_subnet.*.id
  private_dns_enabled = true
}

resource "aws_vpc_endpoint" "ecr_logs_endpoint" {
  vpc_id            = aws_vpc.main.id
  service_name      = "com.amazonaws.${var.region}.logs"
  vpc_endpoint_type = "Interface"

  security_group_ids = [
    aws_security_group.ecr_endpoint_vpce_sg.id,
  ]

  subnet_ids      = aws_subnet.private_subnet.*.id
  private_dns_enabled = true
}