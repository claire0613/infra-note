# ============================================================
# Output Values
# ============================================================

# -----------------------------
# EC2 Instance Outputs
# -----------------------------
output "instance_id" {
  description = "The ID of the EC2 instance"
  value       = aws_instance.main.id
}

output "instance_public_ip" {
  description = "The public IP address of the EC2 instance"
  value       = aws_instance.main.public_ip
}

output "instance_public_dns" {
  description = "The public DNS name of the EC2 instance"
  value       = aws_instance.main.public_dns
}

# -----------------------------
# SSH Connection
# -----------------------------
output "ssh_command" {
  description = "Command to SSH into the EC2 instance"
  value       = "ssh -i ${var.key_name}.pem ec2-user@${aws_instance.main.public_ip}"
}

output "private_key_path" {
  description = "Path to the private key file"
  value       = local_file.private_key.filename
}

# -----------------------------
# VPC Outputs
# -----------------------------
output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}

output "public_subnet_id" {
  description = "The ID of the public subnet"
  value       = aws_subnet.public.id
}

# -----------------------------
# Security Group Outputs
# -----------------------------
output "security_group_id" {
  description = "The ID of the security group"
  value       = aws_security_group.ec2.id
}
