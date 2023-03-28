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
variable "WORKER_IP" {}
# variable "PEM_KEYPAIR_CONTENT" {}
variable "SG_MANAGER_ID" {}
variable "MANAGER_IP" {}