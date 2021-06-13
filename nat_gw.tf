resource "aws_nat_gateway" "nat_gw" {
  count = var.create_private_subnet ? 1 : 0

  allocation_id = aws_eip.nat.0.id
  subnet_id     = aws_subnet.public.0.id
  tags          = var.tags

  depends_on = [
    aws_subnet.public,
    aws_eip.nat
  ]
}

resource "aws_eip" "nat" {
  count = var.create_private_subnet ? 1 : 0

  vpc  = true
  tags = var.tags
}
