##SG
resource "aws_security_group" "manager-sg" {

  vpc_id      = var.VPC_ID
  description = "${var.ENV}-${var.PROJECT_NAME}-manager-SG"
  name        = "${var.ENV}-${var.PROJECT_NAME}-manager"
}

resource "aws_security_group_rule" "rule-manager-ingress-1" {
  for_each = var.MANAGER_PORT
  security_group_id = aws_security_group.manager-sg.id
  type              = "ingress"
  from_port         = each.key
  to_port           = each.value
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}


resource "aws_security_group_rule" "rule-manager-egress" {
  security_group_id = aws_security_group.manager-sg.id
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}