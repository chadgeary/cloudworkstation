## COMMON ##
# public ssh key
instance_key = "ssh-rsa AAAAreplace_me_replace_me_replace_me"

# the ip subnet permitted to connect to guacamole 
mgmt_cidr = "a.b.c.d/32"

# existing aws iam user granted access to the kms key (for browsing KMS encrypted services like S3 or SNS).
kms_manager = "some_iam_user"

# the guacadmin and ubuntu user password - note the EC2 instance has access to this secret (a consideration for multi-user setups).
cw_password = "changeme"

# region to build the services in
aws_region = "us-east-1"

# desktop, either xfce or gnome
desktop = "xfce"

## UNCOMMON ##
# aws profile (e.g. from aws configure, usually "default")
aws_profile = "default"

# a short prefix to label various resources
name_prefix = "cw"

# size according to workload, must be amd64 (not arm)
instance_type = "t3.medium"

# the root block size of the instance(s) (in GiB) and storage type: standard, gp2, gp3, io1, io2, sc1, or st1
instance_vol_size = 20
instance_vol_type = "gp3"

# the vendor supplying the AMI and the AMI name - default is official Ubuntu 20.04, must be amd64 (not arm)
# To get the latest in your region, run the command below (replace the region)
# AWS_REGION=us-east-2 && aws ec2 describe-images --region $AWS_REGION --owners 099720109477 --filters 'Name=name,Values=ubuntu/images/hvm-ssd/ubuntu-*-20.04-amd64-server-*' 'Name=state,Values=available' --query 'sort_by(Images, &CreationDate)[-1].Name'
vendor_ami_account_number = "099720109477"
vendor_ami_name_string    = "ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-20210720"

# vpc specific vars, modify these values if there would be overlap with existing resources in the aws account.
vpc_cidr        = "10.10.11.0/24"
net_cidr        = "10.10.11.0/26"
net_instance_ip = "10.10.11.5"

# docker specific vars, modify these values if there would be overlap with existing resources on the ec2 instance (or client networks).
guacnet_cidr           = "172.16.20.0/24"
guacnet_guacd          = "172.16.20.2"
guacnet_guacdb         = "172.16.20.3"
guacnet_guacamole      = "172.16.20.4"
guacnet_webproxy       = "172.16.20.5"
guacnet_duckdnsupdater = "172.16.20.6"

## DUCKDNS HIGHLY SUGGESTED ##
# if using duckdns, set to 1 and fill in the complete domain, e.g.: duckdns_domain = "chadworkstation1.duckdns.org", duckdns_token, and your email address (for letsencrypt notices)
enable_duckdns    = 0
duckdns_domain    = ""
duckdns_token     = ""
letsencrypt_email = ""
