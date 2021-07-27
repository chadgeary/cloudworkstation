# SSM Managed Policy
data "aws_iam_policy" "cw-instance-policy-ssm" {
  arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

# Instance Policy SSM Parameter
resource "aws_iam_policy" "cw-instance-policy-ssmparameter" {
  name        = "${var.name_prefix}-instance-policy-ssmparameter-${random_string.cw-random.result}"
  path        = "/"
  description = "Provides cw instances access to ssm parameter(s)"
  policy      = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "GetSSMParameter",
      "Effect": "Allow",
      "Action": [
        "ssm:GetParameters"
      ],
      "Resource": ["${aws_ssm_parameter.cw-ssm-param-pass.arn}"]
    },
    {
      "Sid": "SSMCMK",
      "Effect": "Allow",
      "Action": "kms:Decrypt",
      "Resource": ["${aws_kms_key.cw-kmscmk-ssm.arn}"]
    }
  ]
}
EOF
}

# Instance Policy S3
resource "aws_iam_policy" "cw-instance-policy-s3" {
  name        = "${var.name_prefix}-instance-policy-s3-${random_string.cw-random.result}"
  path        = "/"
  description = "Provides cw instances access to s3 objects/bucket"
  policy      = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "ListObjectsinBucket",
      "Effect": "Allow",
      "Action": [
        "s3:ListBucket"
      ],
      "Resource": ["${aws_s3_bucket.cw-bucket.arn}"]
    },
    {
      "Sid": "GetObjectsinBucketPrefix",
      "Effect": "Allow",
      "Action": [
        "s3:GetObject",
        "s3:GetObjectVersion"
      ],
      "Resource": ["${aws_s3_bucket.cw-bucket.arn}/*"]
    },
    {
      "Sid": "PutObjectsinBucketPrefix",
      "Effect": "Allow",
      "Action": [
        "s3:PutObject",
        "s3:PutObjectAcl"
      ],
      "Resource": ["${aws_s3_bucket.cw-bucket.arn}/workstation/*","${aws_s3_bucket.cw-bucket.arn}/ssm/*"]
    },
    {
      "Sid": "S3CMK",
      "Effect": "Allow",
      "Action": [
        "kms:Encrypt",
        "kms:ReEncrypt*",
        "kms:GenerateDataKey*",
        "kms:DescribeKey"
      ],
      "Resource": ["${aws_kms_key.cw-kmscmk-s3.arn}"]
    }
  ]
}
EOF
}

# Instance Role
resource "aws_iam_role" "cw-instance-iam-role" {
  name               = "${var.name_prefix}-instance-role-${random_string.cw-random.result}"
  path               = "/"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
      {
          "Action": "sts:AssumeRole",
          "Principal": {
             "Service": "ec2.amazonaws.com"
          },
          "Effect": "Allow",
          "Sid": ""
      }
  ]
}
EOF
}

# Instance Role Attachments
resource "aws_iam_role_policy_attachment" "cw-iam-attach-ssm" {
  role       = aws_iam_role.cw-instance-iam-role.name
  policy_arn = data.aws_iam_policy.cw-instance-policy-ssm.arn
}

resource "aws_iam_role_policy_attachment" "cw-iam-attach-ssmparameter" {
  role       = aws_iam_role.cw-instance-iam-role.name
  policy_arn = aws_iam_policy.cw-instance-policy-ssmparameter.arn
}

resource "aws_iam_role_policy_attachment" "cw-iam-attach-s3" {
  role       = aws_iam_role.cw-instance-iam-role.name
  policy_arn = aws_iam_policy.cw-instance-policy-s3.arn
}

# Instance Profile
resource "aws_iam_instance_profile" "cw-instance-profile" {
  name = "${var.name_prefix}-instance-profile-${random_string.cw-random.result}"
  role = aws_iam_role.cw-instance-iam-role.name
}
