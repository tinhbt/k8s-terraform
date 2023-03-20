variable "VPC_ID" {}
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
variable "WORKER_PORT" {}
variable "WORKER_INSTANCE_TYPE" {}
variable "NUMBER_WORKER_NODE" {}