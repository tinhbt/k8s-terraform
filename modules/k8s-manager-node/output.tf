output "SG_MANAGER_ID" {
  value = aws_security_group.manager-sg.id
}
output "MANAGER_IP" {
  value = aws_spot_instance_request.k8s-manager-node[*].private_ip
}