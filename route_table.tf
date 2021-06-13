### For Public Subnet
resource "aws_route_table" "public" {
  count = var.create_public_subnet ? 1 : 0

  vpc_id = aws_vpc.main.id
  tags   = var.tags

  depends_on = [
    aws_vpc.main
  ]
}

resource "aws_route" "public" {
  count = var.create_public_subnet ? 1 : 0

  gateway_id             = aws_internet_gateway.main.0.id
  route_table_id         = aws_route_table.public.0.id
  destination_cidr_block = "0.0.0.0/0"

  depends_on = [
    aws_internet_gateway.main,
    aws_route_table.public
  ]
}

resource "aws_route_table_association" "public" {
  count = var.create_public_subnet ? length(var.public_subnet_cidr_blocks) : 0

  subnet_id      = element(aws_subnet.public.*.id, count.index)
  route_table_id = aws_route_table.public.0.id

  depends_on = [
    aws_subnet.public,
    aws_route_table.public
  ]
}

### For Private Subnet
resource "aws_route_table" "private" {
  count = var.create_private_subnet ? 1 : 0

  vpc_id = aws_vpc.main.id
  tags   = var.tags

  depends_on = [
    aws_vpc.main
  ]
}

resource "aws_route" "private" {
  count = var.create_private_subnet ? 1 : 0

  route_table_id         = aws_route_table.private.0.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gw.0.id

  depends_on = [
    aws_route_table.private,
    aws_nat_gateway.nat_gw
  ]
}

resource "aws_route_table_association" "private" {
  count = var.create_private_subnet ? length(var.private_subnet_cidr_blocks) : 0

  subnet_id      = element(aws_subnet.private.*.id, count.index)
  route_table_id = aws_route_table.private.0.id

  depends_on = [
    aws_subnet.private,
    aws_route_table.private
  ]
}
