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
  vpc_id        = "vpc-07635186cc0801e54"
  subnet_id     = "subnet-0d50ecc923f481000"
  instance_type = "t2.micro"
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
    playbook_file = "playbook/playbook.yml"
    use_proxy     = "false"
    user          = "ec2-user"

  }
}



