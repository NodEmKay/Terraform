# VPC Module
resource "aws_vpc" "this" {
  cidr_block = var.cidr_block
  tags      = merge(var.tags, { Name = "vpc-${var.tags["Environment"]}" })
}

resource "aws_subnet" "this" {
  count             = length(var.subnet_cidrs)
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.subnet_cidrs[count.index]
  availability_zone = var.availability_zones[count.index]
  tags              = merge(var.tags, { Name = "subnet-${var.tags["Environment"]}-${count.index + 1}" })
}
