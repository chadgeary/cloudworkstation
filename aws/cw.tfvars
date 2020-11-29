# aws profile (e.g. from aws configure, usually "default")
aws_profile = "default"
aws_region = "us-east-1"

# existing aws iam user granted access to the kms key (for browsing KMS encrypted services like S3 or SNS).
kms_manager = "some_iam_user"

# the ip subnet permitted to connect to guacamole 
mgmt_cidr = "a.b.c.d/32"

# a short prefix to label various resources
name_prefix = "cw"

# public ssh key
instance_key = "ssh-rsa AAAAreplace_me_replace_me_replace_me"

# size according to workload
instance_type = "t3a.medium"

# the root block size of the instance(s) (in GiB)
instance_vol_size = 20

# the vendor supplying the AMI and the AMI name - default is official Ubuntu 20.04
vendor_ami_account_number = "099720109477"
vendor_ami_name_string = "ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-20201112.1"

# vpc specific vars, modify these values if there would be overlap with existing resources in the aws account.
vpc_cidr = "10.10.11.0/24"
net_cidr = "10.10.11.0/26"
net_instance_ip = "10.10.11.5"

# docker specific vars, modify these values if there would be overlap with existing resources on the ec2 instance (or client networks).
guacnet_cidr = "172.16.20.0/24"
guacnet_guacd = "172.16.20.2"
guacnet_guacdb = "172.16.20.3"
guacnet_guacamole = "172.16.20.4"
guacnet_webproxy = "172.16.20.5"
guacnet_wireguard = "172.16.20.6"

# wireguard specific vars, modify these values if there would be overlap with existing resources on the ec2 instance (or client networks).
wireguard_network = "172.16.21.0"
