# security groups
resource "aws_security_group" "cw-sg" {
  name        = "${var.name_prefix}-sg"
  description = "Security group for public traffic"
  vpc_id      = aws_vpc.cw-vpc.id
  tags = {
    Name = "cw-sg"
  }
}

# public sg rules
resource "aws_security_group_rule" "cw-sg-mgmt-ssh-in" {
  security_group_id = aws_security_group.cw-sg.id
  type              = "ingress"
  description       = "IN FROM MGMT - SSH MGMT"
  from_port         = "22"
  to_port           = "22"
  protocol          = "tcp"
  cidr_blocks       = [var.mgmt_cidr]
}

resource "aws_security_group_rule" "cw-sg-mgmt-https-in" {
  security_group_id = aws_security_group.cw-sg.id
  type              = "ingress"
  description       = "IN FROM SELF, MGMT - HTTPS"
  from_port         = "443"
  to_port           = "443"
  protocol          = "tcp"
  cidr_blocks       = [var.mgmt_cidr, "${aws_eip.cw-eip-1.public_ip}/32"]
}

resource "aws_security_group_rule" "cw-sg-out-tcp" {
  security_group_id = aws_security_group.cw-sg.id
  type              = "egress"
  description       = "OUT TO WORLD - TCP"
  from_port         = 0
  to_port           = 65535
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "cw-sg-out-udp" {
  security_group_id = aws_security_group.cw-sg.id
  type              = "egress"
  description       = "OUT TO WORLD - UDP"
  from_port         = 0
  to_port           = 65535
  protocol          = "udp"
  cidr_blocks       = ["0.0.0.0/0"]
}
