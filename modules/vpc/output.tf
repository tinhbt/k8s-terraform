output "VPC_ID" {
  value = aws_vpc.vpc.id
}
output "PRIVATE_SUBNET" {
  value = aws_subnet.private_subnet
}
output "PUBLIC_SUBNET" {
  value = aws_subnet.public_subnet
}
output "PUBLIC_SUBNET_ID" {
  value = [for subnet in aws_subnet.public_subnet : subnet.id]
}

