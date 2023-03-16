variable "VPC_ID" {}
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
