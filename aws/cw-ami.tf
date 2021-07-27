# Vendor AMI
data "aws_ami" "cw-vendor-ami-latest" {
  most_recent = true
  owners      = [var.vendor_ami_account_number]
  filter {
    name   = "name"
    values = [var.vendor_ami_name_string]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}

# Create AMI with KMS CMK from latest Vendor AMI
resource "aws_ami_copy" "cw-latest-vendor-ami-with-cmk" {
  name              = "${var.name_prefix}-encrypted-ami-${random_string.cw-random.result}"
  description       = "KMS CMK-encrypted AMI of latest official vendor AMI"
  source_ami_id     = data.aws_ami.cw-vendor-ami-latest.id
  source_ami_region = var.aws_region
  encrypted         = true
  kms_key_id        = aws_kms_key.cw-kmscmk-ec2.arn
  tags = {
    Name = "${var.name_prefix}-encrypted-ami-${random_string.cw-random.result}"
  }
}
