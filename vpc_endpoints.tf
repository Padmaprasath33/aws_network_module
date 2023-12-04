resource "aws_vpc_endpoint" "s3_endpoint" {
  vpc_id       = aws_vpc.main.id
  service_name = var.s3_enpoint_service_name
}

resource "aws_vpc_endpoint_route_table_association" "s3_endpoint_route_table_association" {
  count          = var.az_count
  route_table_id = element(aws_route_table.private_route_table.*.id, count.index)
  vpc_endpoint_id = aws_vpc_endpoint.s3_endpoint.id
}

resource "aws_vpc_endpoint" "dynamodb_endpoint" {
  vpc_id       = aws_vpc.main.id
  service_name = var.dynamodb_enpoint_service_name
}

resource "aws_vpc_endpoint_route_table_association" "dynamodb_endpoint_route_table_association" {
  count          = var.az_count
  route_table_id = element(aws_route_table.private_route_table.*.id, count.index)
  vpc_endpoint_id = aws_vpc_endpoint.dynamodb_endpoint.id
}