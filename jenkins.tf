
resource "aws_instance" "jenkins" {
  ami                    = "ami-0568773882d492fc8"
  instance_type          = "c5.xlarge"
  subnet_id              = "subnet-0b420fe9b1237e771"
  vpc_security_group_ids = [aws_security_group.chandra.id]
  iam_instance_profile   = aws_iam_instance_profile.cicd-iam.name
  key_name               = aws_key_pair.sep.id




  /* user_data = <<-EOF
  #!/bin/bash
  wget -O /etc/yum.repos.d/jenkins.repo \
 https://pkg.jenkins.io/redhat-stable/jenkins.repo
 rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
 yum upgrade -y
 yum install java-11-openjdk -y
 yum install jenkins -y
  
   

  EOF  */


  user_data = <<-EOF
#!/bin/bash
 yum update -y
 sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
 sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
 yum install epel-release # repository that provides 'daemonize'
 amazon-linux-extras install epel -y
 amazon-linux-extras install java-openjdk11 -y
#  yum install java-11-openjdk-devel
 yum install jenkins -y
 systemctl start jenkins
 systemctl enable jenkins
EOF

  tags = {
    Name = "stage-jenkins"
  }
}