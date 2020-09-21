# security groups
resource "aws_security_group" "cw-pubsg1" {
  name                    = "cw-pubsg1"
  description             = "Security group for public traffic"
  vpc_id                  = aws_vpc.cw-vpc.id
  tags = {
    Name = "cw-pubsg1"
  }
}

# public sg rules
resource "aws_security_group_rule" "cw-pubsg1-mgmt-ssh-in" {
  security_group_id       = aws_security_group.cw-pubsg1.id
  type                    = "ingress"
  description             = "IN FROM MGMT - SSH MGMT"
  from_port               = "22"
  to_port                 = "22"
  protocol                = "tcp"
  cidr_blocks             = [var.mgmt_cidr]
}

resource "aws_security_group_rule" "cw-pubsg1-mgmt-https-in" {
  security_group_id       = aws_security_group.cw-pubsg1.id
  type                    = "ingress"
  description             = "IN FROM MGMT - HTTPS"
  from_port               = "443"
  to_port                 = "443"
  protocol                = "tcp"
  cidr_blocks             = [var.mgmt_cidr]
}

resource "aws_security_group_rule" "cw-pubsg1-mgmt-http-in" {
  security_group_id       = aws_security_group.cw-pubsg1.id
  type                    = "ingress"
  description             = "IN FROM MGMT - HTTP CUSTOM"
  from_port               = "8080"
  to_port                 = "8080"
  protocol                = "tcp"
  cidr_blocks             = [var.mgmt_cidr]
}

resource "aws_security_group_rule" "cw-pubsg1-out" {
  security_group_id       = aws_security_group.cw-pubsg1.id
  type                    = "egress"
  description             = "OUT - WORLD"
  from_port               = 0
  to_port                 = 65535
  protocol                = "tcp"
  cidr_blocks             = ["0.0.0.0/0"]
}
