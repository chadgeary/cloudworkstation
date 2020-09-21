# vpc and gateway
resource "aws_vpc" "cw-vpc" {
  cidr_block              = var.vpc_cidr
  enable_dns_support      = "true"
  enable_dns_hostnames    = "true"
  tags                    = {
    Name                  = "cw-vpc"
  }
}

# internet gateway 
resource "aws_internet_gateway" "cw-gw" {
  vpc_id                  = aws_vpc.cw-vpc.id
  tags                    = {
    Name                  = "cw-gw"
  }
}

# public route table
resource "aws_route_table" "cw-pubrt" {
  vpc_id                  = aws_vpc.cw-vpc.id
  route {
    cidr_block              = "0.0.0.0/0"
    gateway_id              = aws_internet_gateway.cw-gw.id
  }
  tags                    = {
    Name                  = "cw-pubrt"
  }
}

# public subnets
resource "aws_subnet" "cw-pubnet1" {
  vpc_id                  = aws_vpc.cw-vpc.id
  availability_zone       = data.aws_availability_zones.cw-azs.names[0]
  cidr_block              = var.pubnet1_cidr
  tags                    = {
    Name                  = "cw-pubnet1"
  }
  depends_on              = [aws_internet_gateway.cw-gw]
}

# public route table associations
resource "aws_route_table_association" "rt-assoc-pubnet1" {
  subnet_id               = aws_subnet.cw-pubnet1.id
  route_table_id          = aws_route_table.cw-pubrt.id
}
