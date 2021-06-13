variable "tags" {
  type = map(any)
}

variable "vpc_name" {
  type = string
}

variable "vpc_cidr_block" {
  type = string
}

variable "create_public_subnet" {
  type    = bool
  default = false
}

variable "public_subnet_cidr_blocks" {
  type    = list(string)
  default = []
}

variable "create_private_subnet" {
  type    = bool
  default = false
}

variable "private_subnet_cidr_blocks" {
  type    = list(string)
  default = []
}

variable "azs" {
  type = list(string)
  default = []
}
