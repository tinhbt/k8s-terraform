#VPC VAR
variable "VPC_CIDR" {
  type        = string
  description = "The IP range to use for the VPC"
}

variable "PUBLIC_SUBNET_NUMBERS" {
  type        = map(number)
  description = "Map of AZ to a number that should be used for public subnets"
}

variable "PRIVATE_SUBNET_NUMBERS" {
  type        = map(number)
  description = "Map of AZ to a number that should be used for private subnets"
}
variable "ENV" {
  type        = string
  description = "Environment infra"
}
variable "PROJECT_NAME" {
  type        = string
  description = "Project name infra"
}
