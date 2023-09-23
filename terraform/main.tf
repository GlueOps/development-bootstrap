provider "aws" {
  region = var.aws_region
  access_key = ""
  secret_key = ""
}

module "code_tunnel_sg" {
  source = "./security_group"
  vpc_id = "vpc-096b3742dd109c564"
}

module "code_tunnel_test_vm" {
  source = "./ec2_instance"
  vpc_id = "vpc-096b3742dd109c564"
  subnet_id = "subnet-0df3fe7264ba9cb9b"
  instance_type = "t3.xlarge"
  root_volume_size = 50
  ebs_volume_size = 50
  key_pair = "balaji-vs-code-server"
  ami_id = "ami-093aedfa2e31f277f"
  vpc_security_group_ids = [module.code_tunnel_sg.code_tunnel_sg.id]
  instance_name = "code-tunnel-test-vm"
}

// Add multiple development machines by adding module like above with respective values.

