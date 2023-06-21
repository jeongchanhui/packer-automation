locals {
  timestamp = regex_replace(timestamp(), "[- TZ:]", "")
}


data "amazon-ami" "amzn2-lts" {
  filters = {
    name                = "amzn2-ami-hvm-*-x86_64-gp2"
    root-device-type    = "ebs"
    virtualization-type = "hvm"
  }
  most_recent = true
  owners      = ["amazon"]
}

source "amazon-ebs" "base-linux-ami" {
  region        = "ap-northeast-2"
  ami_name      = "amzn2-base-ami-${local.timestamp}"
  source_ami    = data.amazon-ami.amzn2-lts.id
  vpc_id        = var.vpc_id
  subnet_id     = var.vpc_subnet_id
  instance_type = "t3.small"
  ssh_username  = "ec2-user"
  tags = {
    Name          = "amzn2-base-ami-${local.timestamp}"
    Base_AMI_ID   = "{{ .SourceAMI }}"
    Base_AMI_Name = "{{ .SourceAMIName }}"
  }
}


build {
  sources = [
    "source.amazon-ebs.base-linux-ami"
  ]

  provisioner "ansible" {
    playbook_file = "playbook.yml"
    use_proxy     = "false"
    user          = "ec2-user"

  }
}



