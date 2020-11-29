output "cloudworkstation-output" {
  value = <<OUTPUT
  
  #############  
  ## OUTPUTS ##
  #############
  
  ## SSH ##
  ssh ubuntu@${aws_eip.cw-eip-1.public_ip}
  
  ## WebUI ##
  # Username: guacadmin
  https://${aws_eip.cw-eip-1.public_ip}/guacamole/
  
  ## Update / Ansible Rerun ##
  mv cw.tfvars pvars.tfvars
  git pull
  diff pvars.tfvars cw.tfvars
  mv pvars.tfvars cw.tfvars
  terraform apply -var-file="cw.tfvars"
  ~/.local/bin/aws ssm start-associations-once --region ${var.aws_region} --association-ids ${aws_ssm_association.cw-ssm-assoc.association_id}
  OUTPUT
}
