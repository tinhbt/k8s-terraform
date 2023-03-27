resource "aws_subnet" "private_subnet" {
  vpc_id = aws_vpc.vpc.id #get vpc id

  for_each          = var.PRIVATE_SUBNET_NUMBERS
  availability_zone = each.key
  cidr_block        = cidrsubnet(aws_vpc.vpc.cidr_block, 8, each.value)
  tags = {
    Name   = "${var.ENV}-${var.PROJECT_NAME}-private-subnet"
    Role   = "private"
    Subnet = "${each.key}-${each.value}"
  }
}
#Create rtb with route and subnet association
resource "aws_route_table" "private_rtb" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.ENV}-${var.PROJECT_NAME}"
  }
}
##route to local and natgw
# resource "aws_route" "private" {

#   route_table_id         = aws_route_table.private_rtb.id
#   destination_cidr_block = var.VPC_CIDR

# }
# ##Associate with private subnet
# resource "aws_route_table_association" "private" {
#   for_each       = aws_subnet.private_subnet
#   subnet_id      = each.value.id
#   route_table_id = aws_route_table.private_rtb.id
# }