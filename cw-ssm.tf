# zookeepers
resource "aws_ssm_association" "cw-ssm-assoc" {
  association_name        = "cw-workstation"
  name                    = "AWS-ApplyAnsiblePlaybooks"
  targets {
    key                   = "tag:cw"
    values                = ["True"]
  }
  output_location {
    s3_bucket_name          = aws_s3_bucket.cw-bucket.id
    s3_key_prefix           = "ssm"
  }
  parameters              = {
    Check                   = "False"
    ExtraVariables          = "SSM=True guacnet_cidr=${var.guacnet_cidr} guacnet_guacd=${var.guacnet_guacd} guacnet_guacdb=${var.guacnet_guacdb} guacnet_guacamole=${var.guacnet_guacamole}"
    InstallDependencies     = "True"
    PlaybookFile            = "workstation.yml"
    SourceInfo              = "{\"path\":\"https://s3.${var.aws_region}.amazonaws.com/${aws_s3_bucket.cw-bucket.id}/workstation/\"}"
    SourceType              = "S3"
    Verbose                 = "-v"
  }
  depends_on              = [aws_iam_role_policy_attachment.cw-iam-attach-ssm, aws_iam_role_policy_attachment.cw-iam-attach-s3,aws_s3_bucket_object.cw-workstation-files]
}
