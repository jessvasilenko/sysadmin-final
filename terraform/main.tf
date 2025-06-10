data "aws_key_pair" "deployer" {
  key_name = var.key_name
}

resource "aws_security_group" "minecraft_sg" {
  name        = "minecraft_sg"
  description = "Allow Minecraft traffic"

  ingress {
    from_port   = 25565
    to_port     = 25565
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "minecraft" {
  ami           = "ami-03f8acd418785369b" 
  instance_type = var.instance_type
  key_name      = data.aws_key_pair.deployer.key_name

  vpc_security_group_ids = [aws_security_group.minecraft_sg.id]

  tags = {
    Name = "minecraft-server"
  }
}
