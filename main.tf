
module "vpc" {
  source = "./modules/vpc"

  #vpc_name= var.VPC_NAME
  ENV                    = var.ENV
  PROJECT_NAME           = var.PROJECT_NAME
  VPC_CIDR               = var.VPC_CIDR
  PUBLIC_SUBNET_NUMBERS  = var.PUBLIC_SUBNET_NUMBERS
  PRIVATE_SUBNET_NUMBERS = var.PRIVATE_SUBNET_NUMBERS
}
module "k8s-manager-deploy-node" {
  source                = "./modules/k8s-manager-deploy-node"
  ENV                   = var.ENV
  PROJECT_NAME          = var.PROJECT_NAME
  MANAGER_PORT          = var.MANAGER_PORT
  MANAGER_INSTANCE_TYPE = var.MANAGER_INSTANCE_TYPE
  KEY_NAME              = var.KEY_NAME
  VPC_ID                = module.vpc.VPC_ID
  PUBLIC_SUBNET         = module.vpc.PUBLIC_SUBNET
  WORKER_IP             = module.k8s-worker.WORKER_IP
  SUBNET_ID             = module.vpc.PUBLIC_SUBNET_ID[0]
  SG_MANAGER_ID         = module.k8s-manager-node.SG_MANAGER_ID
  MANAGER_IP            = module.k8s-manager-node.MANAGER_IP
  depends_on = [
    module.k8s-worker,
    module.k8s-manager-node,
  ]
}
module "k8s-manager-node" {
  source                = "./modules/k8s-manager-node"
  ENV                   = var.ENV
  PROJECT_NAME          = var.PROJECT_NAME
  MANAGER_PORT          = var.MANAGER_PORT
  MANAGER_INSTANCE_TYPE = var.MANAGER_INSTANCE_TYPE
  KEY_NAME              = var.KEY_NAME
  NUMBER_MANAGER_NODE   = var.NUMBER_MANAGER_NODE
  VPC_ID                = module.vpc.VPC_ID
  PUBLIC_SUBNET         = module.vpc.PUBLIC_SUBNET
  SUBNET_ID             = module.vpc.PUBLIC_SUBNET_ID[0]
}
module "k8s-worker" {
  source               = "./modules/k8s-worker"
  ENV                  = var.ENV
  PROJECT_NAME         = var.PROJECT_NAME
  WORKER_PORT          = var.WORKER_PORT
  WORKER_INSTANCE_TYPE = var.WORKER_INSTANCE_TYPE
  NUMBER_WORKER_NODE   = var.NUMBER_WORKER_NODE
  KEY_NAME             = var.KEY_NAME
  VPC_ID               = module.vpc.VPC_ID
  SUBNET_ID            = module.vpc.PUBLIC_SUBNET_ID[0]
  depends_on = [
    module.k8s-manager-node,
  ]
}
output "WORKER_IP" {
  value = module.k8s-worker.WORKER_IP
}
output "DEPLOY_NODE_IP" {
  value = module.k8s-manager-deploy-node.DEPLOY_NODE_IP
}