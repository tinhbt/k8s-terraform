
variable "MANAGER_PORT" {}
variable "MANAGER_INSTANCE_TYPE" {}
# variable "PEM_KEYPAIR_CONTENT" {}
variable "WORKER_PORT" {}
variable "WORKER_INSTANCE_TYPE" {}
variable "NUMBER_WORKER_NODE" {
  type = number
}
variable "KEY_NAME" {}

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
