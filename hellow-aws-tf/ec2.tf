
resource "aws_instance" "public-ec2" {
    ami           = var.ami_id
    instance_type = var.instance_type
    subnet_id     = module.vpc.subnet_public_id
    key_name      = "sre-challenge-key-pair"
    vpc_security_group_ids = [ aws_security_group.ec2-sg.id ]
    associate_public_ip_address = true

    tags = {
        Name = "EC2-SRE-Challenge"
    }

    depends_on = [ module.vpc.vpc_id, module.vpc.igw_id, aws_db_instance.default ]

    user_data = <<EOF
#!/bin/sh
sudo yum update -y
EOF
}

resource "aws_security_group" "ec2-sg" {
  name        = "security-group"
  description = "allow inbound access to the EC2 instance"
  vpc_id      = module.vpc.vpc_id

  ingress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}
