output "cloudworkstation-output" {
  value = <<OUTPUT
## SSH ##
ssh ubuntu@${aws_eip.cw-eip-1.public_ip}
  
## WebUI ##
# Username: guacadmin
https://${var.enable_duckdns == 1 ? var.duckdns_domain : aws_eip.cw-eip-1.public_ip}/guacamole/
  
## Container Updates ##
# SSH (or RDP) to instance
ssh ubuntu@${aws_eip.cw-eip-1.public_ip}
# Remove old containers
sudo docker rm -f web_proxy guacamole guacdb guacd duckdnsupdater
# Re-run the playbook via AWS SSM from your local machine
~/.local/bin/aws ssm start-associations-once --region ${var.aws_region} --association-ids ${aws_ssm_association.cw-ssm-assoc.association_id}
OUTPUT
}
