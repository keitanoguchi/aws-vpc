resource "aws_internet_gateway" "main" {
  count = var.create_public_subnet ? 1 : 0

  vpc_id = aws_vpc.main.id
  tags   = var.tags

  depends_on = [
    aws_vpc.main
  ]
}
