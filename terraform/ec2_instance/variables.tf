
variable "vpc_id" {
  description = "VPC ID"
}

variable "subnet_id" {
  description = "Subnet ID"
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t3.large"
}

variable "root_volume_size" {
  description = "Size (in GB) of the root volume"
  default     = 50
}

variable "ebs_volume_size" {
  description = "Size (in GB) of the external EBS volume"
  default     = 50
}

variable "key_pair" {
  description = "Name of the SSH key pair"
  default     = "balaji-vs-code-server"
}

variable "ami_id" {
  description = "AMI to launch the instance from"
  default     = "ami-0a6f6f0e3104a576d"
}

variable "vpc_security_group_ids" {
  description = "Security group IDs for the ec2"
}

variable "instance_name" {
  description = "Name of the EC2 instance"
}

