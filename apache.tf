resource "aws_instance" "apache" {
  ami                    = "ami-0568773882d492fc8"
  instance_type          = "t3.micro"
  subnet_id              = "subnet-086a44e553dc08526"
  vpc_security_group_ids = [aws_security_group.jenkins.id]
  key_name               = aws_key_pair.sep.id
  user_data              = <<-EOF
 #!/bin/bash
 yum install httpd -y
 yum update httpd -y
 systemctl start httpd
 systemctl enable httpd
 EOF
  tags = {
    Name = "stage-apache"
  }
}