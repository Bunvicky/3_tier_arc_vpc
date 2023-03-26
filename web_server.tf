#Create EC2 Instance
resource "aws_instance" "webserver1" {
  ami                    = "ami-02c61cf220bd1158e"
  instance_type          = "t2.micro"
  availability_zone      = "us-west-1b"
  vpc_security_group_ids = [aws_security_group.webserver-sg.id]
  subnet_id              = aws_subnet.web-subnet-1.id
  user_data              = file("install_apache.sh")

  tags = {
    Name = "Web Server"
  }

}

resource "aws_instance" "webserver2" {
  ami                    = "ami-02c61cf220bd1158e"
  instance_type          = "t2.micro"
  availability_zone      = "us-west-1c"
  vpc_security_group_ids = [aws_security_group.webserver-sg.id]
  subnet_id              = aws_subnet.web-subnet-2.id
  user_data              = file("install_apache.sh")

  tags = {
    Name = "Web Server"
  }

}