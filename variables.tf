variable "tags" {
  type = map(any)
}

variable "vpc_name" {
  type = string
}

variable "vpc_cidr_block" {
  type = string
}

variable "public_subnet_cidr_blocks" {
  type = list(string)
}

variable "azs" {
  type = list(string)
}
