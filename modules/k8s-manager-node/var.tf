variable "VPC_ID" {}
variable "PUBLIC_SUBNET" {}
variable "KEY_NAME" {}
variable "ENV" {
  type        = string
  description = "Environment infra"
}
variable "PROJECT_NAME" {
  type        = string
  description = "Project name infra"
}
variable "SUBNET_ID" {}
variable "MANAGER_PORT" {}
variable "MANAGER_INSTANCE_TYPE" {}
variable "NUMBER_MANAGER_NODE" {}