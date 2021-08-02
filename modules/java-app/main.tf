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

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.app_instance_type

  subnet_id = var.subnet_id

  tags = {
    Name = var.app_name
  }
}

# TODO: Loop and crate multipe instances / Autoscaling groups etc

# TODO: Create Security group

# TODO: Write user data script install run docker images

# TODO: Add to ELB

# Note: EC2 can be replace with ECS for simplifying container deployment
