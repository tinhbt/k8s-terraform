
module "vpc" {
  source = "./modules/vpc"

  #vpc_name= var.VPC_NAME
  ENV                    = var.ENV
  PROJECT_NAME           = var.PROJECT_NAME
  VPC_CIDR               = var.VPC_CIDR
  PUBLIC_SUBNET_NUMBERS  = var.PUBLIC_SUBNET_NUMBERS
  PRIVATE_SUBNET_NUMBERS = var.PRIVATE_SUBNET_NUMBERS
}
module "k8s-manager" {
  source = "./modules/k8s-manager"
  ENV                    = var.ENV
  PROJECT_NAME           = var.PROJECT_NAME
  VPC_ID = module.vpc.VPC_ID
  PUBLIC_SUBNET = module.vpc.PUBLIC_SUBNET
  MANAGER_PORT = var.MANAGER_PORT
  WORKER_IP = module.k8s-worker.WORKER_IP
  MANAGER_INSTANCE_TYPE = var.MANAGER_INSTANCE_TYPE
  # PEM_KEYPAIR_CONTENT = var.PEM_KEYPAIR_CONTENT
  SUBNET_ID = module.vpc.PUBLIC_SUBNET_ID[0]
  depends_on = [
    module.k8s-worker,
  ]
}
module "k8s-worker" {
  source = "./modules/k8s-worker"
  ENV                    = var.ENV
  PROJECT_NAME           = var.PROJECT_NAME
  WORKER_PORT = var.WORKER_PORT
  WORKER_INSTANCE_TYPE = var.WORKER_INSTANCE_TYPE
  NUMBER_WORKER_NODE = var.NUMBER_WORKER_NODE
  VPC_ID = module.vpc.VPC_ID
  SUBNET_ID = module.vpc.PUBLIC_SUBNET_ID[0]
}
 output "WORKER_IP" {
   value = module.k8s-worker.WORKER_IP
 }
