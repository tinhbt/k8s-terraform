#Create VPC
resource "aws_vpc" "vpc" {
  cidr_block = var.VPC_CIDR

  tags = {
    Name = "${var.ENV}-${var.PROJECT_NAME}"
  }
}
#Create igw
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.ENV}-${var.PROJECT_NAME}"
  }
}
