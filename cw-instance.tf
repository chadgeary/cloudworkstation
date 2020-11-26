# Instance Key
resource "aws_key_pair" "cw-instance-key" {
  key_name                = "${var.name_prefix}-instance-key-${random_string.cw-random.result}"
  public_key              = var.instance_key
  tags                    = {
    Name                    = "${var.name_prefix}-instance-key"
  }
}

# Instance(s)
resource "aws_instance" "cw-instance-1" {
  ami                     = aws_ami_copy.cw-latest-vendor-ami-with-cmk.id
  instance_type           = var.instance_type
  iam_instance_profile    = aws_iam_instance_profile.cw-instance-profile.name
  key_name                = aws_key_pair.cw-instance-key.key_name
  subnet_id               = aws_subnet.cw-net.id
  private_ip              = var.net_instance_ip
  vpc_security_group_ids  = [aws_security_group.cw-sg.id]
  tags                    = {
    Name                    = "${var.name_prefix}-workstation-1-${random_string.cw-random.result}",
    cw                      = "True"
  }
  user_data               = <<EOF
#!/bin/bash
# set hostname
hostnamectl set-hostname ${var.name_prefix}-workstation-1-${random_string.cw-random.result}
EOF
  root_block_device {
    volume_size             = var.instance_vol_size
    volume_type             = "standard"
    encrypted               = "true"
    kms_key_id              = aws_kms_key.cw-kmscmk-ec2.arn
  }
  depends_on              = [aws_iam_role_policy_attachment.cw-iam-attach-ssm, aws_iam_role_policy_attachment.cw-iam-attach-s3]
}

# Elastic IP for Instance(s)
resource "aws_eip" "cw-eip-1" {
  vpc                     = true
  instance                = aws_instance.cw-instance-1.id
  associate_with_private_ip = var.net_instance_ip
  depends_on              = [aws_internet_gateway.cw-gw]
}

output "cw-eip-1-output" {
  value                   = aws_eip.cw-eip-1.public_ip
}
