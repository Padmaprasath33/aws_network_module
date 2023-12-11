data "aws_availability_zones" "available" {
}

resource "aws_vpc" "main" {
  cidr_block = var.cidr_block
  enable_dns_support = true
  enable_dns_hostnames = true
  //tags = var.resource_tags
  tags = {
    name        = "2191420-vpc-main"
    project     = "aws-proserv",
    environment = "dev"
    application = "cohort-demo"
  }
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.main.id
  tags = var.resource_tags
}

resource "aws_route" "internet_access" {
  route_table_id         = aws_vpc.main.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.internet_gateway.id
}


//Data source EIP - So commented this block
resource "aws_eip" "elastic_ip" {
  count      = var.az_count
  domain        = "vpc"
  depends_on = [aws_internet_gateway.internet_gateway]
  tags = var.resource_tags
}


/*data "aws_eip" "elastic_ip_1" {
  id = "eipalloc-059f31f7bc6943a7f"
  depends_on = [aws_internet_gateway.internet_gateway]
}

data "aws_eip" "elastic_ip_2" {
  id = "eipalloc-003aea23366de83e4"
  depends_on = [aws_internet_gateway.internet_gateway]
}
*/


resource "aws_subnet" "private_subnet" {
  count             = var.az_count
  cidr_block        = cidrsubnet(aws_vpc.main.cidr_block, 8, count.index)
  availability_zone = data.aws_availability_zones.available.names[count.index]
  vpc_id            = aws_vpc.main.id
  tags = var.resource_tags
}

resource "aws_subnet" "public_subnet" {
  count                   = var.az_count
  cidr_block              = cidrsubnet(aws_vpc.main.cidr_block, 8, var.az_count + count.index)
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  vpc_id                  = aws_vpc.main.id
  map_public_ip_on_launch = true
  tags = var.resource_tags
}

 
//Data source EIP - So commented this block
resource "aws_nat_gateway" "nat_gateway" {
  count         = var.az_count
  subnet_id     = element(aws_subnet.public_subnet.*.id, count.index)
  allocation_id = element(aws_eip.elastic_ip.*.id, count.index)
  tags = var.resource_tags
}

resource "aws_route_table" "private_route_table" {
  count  = var.az_count
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = element(aws_nat_gateway.nat_gateway.*.id, count.index)
  }
  tags = var.resource_tags
}

resource "aws_route_table_association" "private_route_table_association" {
  count          = var.az_count
  subnet_id      = element(aws_subnet.public_subnet.*.id, count.index)
  route_table_id = element(aws_route_table.private_route_table.*.id, count.index)
}


/*
/// Nat g/w temporary since data source is used for EIP
resource "aws_nat_gateway" "nat_gateway_1" {
  subnet_id     = aws_subnet.public_subnet[0].id
  allocation_id = data.aws_eip.elastic_ip_1.id
  tags = var.resource_tags
}

resource "aws_nat_gateway" "nat_gateway_2" {
  subnet_id     = aws_subnet.public_subnet[1].id
  allocation_id = data.aws_eip.elastic_ip_2.id
  tags = var.resource_tags
}

resource "aws_route_table" "private_route_table_1" {
  //count  = var.az_count
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway_1.id
  }
  tags = var.resource_tags
}

resource "aws_route_table" "private_route_table_2" {
  //count  = var.az_count
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway_2.id
  }
  tags = var.resource_tags
}


resource "aws_route_table_association" "private_route_table_association_1" {
  //count          = var.az_count
  subnet_id      = aws_subnet.private_subnet[0].id
  route_table_id = aws_route_table.private_route_table_1.id
}

resource "aws_route_table_association" "private_route_table_association_2" {
  //count          = var.az_count
  subnet_id      = aws_subnet.private_subnet[1].id
  route_table_id = aws_route_table.private_route_table_2.id
}
*/