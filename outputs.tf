output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_ids" {
  value = var.create_public_subnet ? aws_subnet.public.*.id : []
}

output "private_subnet_ids" {
  value = var.create_private_subnet ? aws_subnet.private.*.id : []
}
