##SG
resource "aws_security_group" "worker-sg" {

  vpc_id      = var.VPC_ID
  description = "${var.ENV}-${var.PROJECT_NAME}-worker-SG"
  name        = "${var.ENV}-${var.PROJECT_NAME}-worker"
}

resource "aws_security_group_rule" "rule-worker-ingress-1" {
  for_each          = var.WORKER_PORT
  security_group_id = aws_security_group.worker-sg.id
  type              = "ingress"
  from_port         = each.key
  to_port           = each.value
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}


resource "aws_security_group_rule" "rule-worker-egress" {
  security_group_id = aws_security_group.worker-sg.id
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}