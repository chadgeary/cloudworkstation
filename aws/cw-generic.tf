variable "aws_region" {
  type = string
}

variable "aws_profile" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "net_cidr" {
  type = string
}

variable "net_instance_ip" {
  type = string
}

variable "guacnet_cidr" {
  type = string
}

variable "guacnet_guacd" {
  type = string
}

variable "guacnet_guacdb" {
  type = string
}

variable "guacnet_guacamole" {
  type = string
}

variable "guacnet_webproxy" {
  type = string
}

variable "guacnet_duckdnsupdater" {
  type = string
}

variable "mgmt_cidr" {
  type        = string
  description = "Subnet CIDR allowed to access WebUI and SSH, e.g. 172.16.10.0/30"
}

variable "instance_type" {
  type        = string
  description = "The type of EC2 instance to deploy"
}

variable "instance_key" {
  type        = string
  description = "A public key for SSH access to instance(s)"
}

variable "instance_vol_size" {
  type        = number
  description = "The volume size of the instances' root block device"
}

variable "instance_vol_type" {
  type        = string
  description = "The type of volume standard, gp2, gp3, io1, io2, sc1, or st1"
}

variable "kms_manager" {
  type        = string
  description = "An IAM user for management of KMS key"
}

variable "name_prefix" {
  type        = string
  description = "A friendly name prefix for the AMI and EC2 instances, e.g. 'cw' or 'dev'"
}

variable "cw_password" {
  type        = string
  description = "The password to replace guacadmin's default Web UI password"
}

variable "desktop" {
  type        = string
  description = "Desktop environment, either gnome or xfce"
}

variable "vendor_ami_account_number" {
  type        = string
  description = "The account number of the vendor supplying the base AMI"
}

variable "vendor_ami_name_string" {
  type        = string
  description = "The search string for the name of the AMI from the AMI Vendor"
}

provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}

# region azs
data "aws_availability_zones" "cw-azs" {
  state = "available"
}

# account id
data "aws_caller_identity" "cw-aws-account" {
}

# kms cmk manager - granted read access to KMS CMKs
data "aws_iam_user" "cw-kmsmanager" {
  user_name = var.kms_manager
}

resource "random_string" "cw-random" {
  length  = 5
  upper   = false
  special = false
}

variable "enable_duckdns" {
  type = number
}

variable "duckdns_domain" {
  type = string
}

variable "duckdns_token" {
  type = string
}

variable "letsencrypt_email" {
  type = string
}
