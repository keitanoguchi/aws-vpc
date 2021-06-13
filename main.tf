# VPC
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(
    {
      Name = var.vpc_name
    },
    var.tags
  )
}

# Subnet
resource "aws_subnet" "public" {
  count = length(var.public_subnet_cidr_blocks) > 0 ? length(var.public_subnet_cidr_blocks) : 0

  cidr_block              = element(var.public_subnet_cidr_blocks, count.index)
  availability_zone       = element(var.azs, count.index)
  vpc_id                  = aws_vpc.main.id
  map_public_ip_on_launch = true
  tags = merge(
    {
      Name = "public-${count.index}"
    },
    var.tags
  )

  depends_on = [aws_vpc.main]
}

# Internet Gateway
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags   = var.tags
}

# Route Table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  tags   = var.tags

  depends_on = [aws_vpc.main]
}

resource "aws_route" "public" {
  count = length(var.public_subnet_cidr_blocks) > 0 ? 1 : 0

  gateway_id             = aws_internet_gateway.main.id
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"

  depends_on = [
    aws_internet_gateway.main,
    aws_route_table.public
  ]
}

resource "aws_route_table_association" "public" {
  count = length(var.public_subnet_cidr_blocks) > 0 ? length(var.public_subnet_cidr_blocks) : 0

  subnet_id      = element(aws_subnet.public.*.id, count.index)
  route_table_id = aws_route_table.public.id

  depends_on = [
    aws_subnet.public,
    aws_route_table.public
  ]
}
