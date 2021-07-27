# vpc and gateway
resource "aws_vpc" "cw-vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  tags = {
    Name = "${var.name_prefix}-vpc-${random_string.cw-random.result}"
  }
}

# internet gateway 
resource "aws_internet_gateway" "cw-gw" {
  vpc_id = aws_vpc.cw-vpc.id
  tags = {
    Name = "${var.name_prefix}-gw-${random_string.cw-random.result}"
  }
}

# public route table
resource "aws_route_table" "cw-pubrt" {
  vpc_id = aws_vpc.cw-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.cw-gw.id
  }
  tags = {
    Name = "${var.name_prefix}-pubrt-${random_string.cw-random.result}"
  }
}

# net
resource "aws_subnet" "cw-net" {
  vpc_id            = aws_vpc.cw-vpc.id
  availability_zone = data.aws_availability_zones.cw-azs.names[0]
  cidr_block        = var.net_cidr
  tags = {
    Name = "${var.name_prefix}-net-${random_string.cw-random.result}"
  }
  depends_on = [aws_internet_gateway.cw-gw]
}

# public route table associations
resource "aws_route_table_association" "rt-assoc-net" {
  subnet_id      = aws_subnet.cw-net.id
  route_table_id = aws_route_table.cw-pubrt.id
}
