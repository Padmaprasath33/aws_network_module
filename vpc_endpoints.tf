resource "aws_vpc_endpoint" "s3_endpoint" {
  vpc_id       = aws_vpc.main.id
  service_name = "com.amazonaws.us-west-2.s3"
}

resource "aws_vpc_endpoint_route_table_association" "s3_endpoint_route_table_association" {
  count          = var.az_count
  route_table_id = element(aws_route_table.private_route_table.*.id, count.index)
  vpc_endpoint_id = aws_vpc_endpoint.s3_endpoint.id
}