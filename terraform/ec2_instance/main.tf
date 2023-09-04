
resource "aws_instance" "example" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  key_name      = var.key_pair
  vpc_security_group_ids = var.vpc_security_group_ids
  root_block_device {
    volume_size = var.root_volume_size
  }
  ebs_block_device {
    device_name = "/dev/xvdf"
    volume_size = var.ebs_volume_size
    volume_type = "gp2" 
    delete_on_termination = true
  }

  user_data = <<-EOF
              #!/bin/bash
               ${file("./ec2_instance/userdata.sh")}
              EOF

  tags = {
    Name = var.instance_name
  }
}
