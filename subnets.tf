resource "aws_subnet" "public" {
  count = var.create_public_subnet ? length(var.public_subnet_cidr_blocks) : 0

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

  depends_on = [
    aws_vpc.main
  ]
}

resource "aws_subnet" "private" {
  count = var.create_private_subnet ? length(var.private_subnet_cidr_blocks) : 0

  cidr_block        = element(var.private_subnet_cidr_blocks, count.index)
  availability_zone = element(var.azs, count.index)
  vpc_id            = aws_vpc.main.id
  tags = merge(
    {
      Name = "private-${count.index}"
    },
    var.tags
  )

  depends_on = [
    aws_vpc.main
  ]
}
