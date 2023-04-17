### Data Source will query the AWS regions AMIs and use filters to discover the AMI ID for Ubuntu 20.04 that is offered by Canonical
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

### Create SSH Keypair 
resource "tls_private_key" "keypair" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "awskey" {
  key_name   = var.owner
  public_key = tls_private_key.keypair.public_key_openssh
}

### Create EC2 Instance using the AMI ID and Keypair
resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.small"
  key_name = aws_key_pair.awskey.key_name

  tags = {
    Name = var.name
    env = var.env
    app = var.owner
    OS   = data.aws_ami.ubuntu.name
    type = data.aws_ami.ubuntu.platform_details
  }
}
