ENV                = "test"
PROJECT_NAME       = "cluster"
NUMBER_WORKER_NODE = 1
KEY_NAME           = "windows"
KEY_PEM_PATH       = "./windows.pem"
MANAGER_PORT = {
  "6443"  = "6443"
  "2379"  = "2380"
  "10250" = "10250"
  "10259" = "10259"
  "10257" = "10257"
  "22"    = "22"
}
WORKER_PORT = {
  "10250" = "10250"
  "30000" = "32767"
  "22"    = "22"
}
# VPC variables
VPC_CIDR = "10.0.0.0/16"
PUBLIC_SUBNET_NUMBERS = {
  "ap-southeast-1a" = 1
  "ap-southeast-1b" = 2
}

PRIVATE_SUBNET_NUMBERS = {
  "ap-southeast-1a" = 3
  "ap-southeast-1b" = 4
}
# PEM_KEYPAIR_CONTENT = 

MANAGER_INSTANCE_TYPE = "t3.medium"
WORKER_INSTANCE_TYPE  = "t3.medium"