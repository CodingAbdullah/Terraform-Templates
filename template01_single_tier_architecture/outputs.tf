output "vpc_id" {
  description = "ID of the VPC"
  value       = module.vpc.vpc_id
}

output "subnet_id" {
  description = "ID of the subnet"
  value       = module.vpc.subnet_id
}

output "instance_id" {
  description = "ID of the EC2 instance"
  value       = module.ec2.instance_id
}

output "instance_public_ip" {
  description = "Public IP of the EC2 instance"
  value       = module.ec2.instance_public_ip
}