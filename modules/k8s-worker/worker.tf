#Get AMI ID
data "aws_ami" "ubuntu-ami" {
  most_recent = true
  owners      = ["099720109477"]
  # name_regex = "ubuntu"
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}
#Read scipt file
data "template_file" "init_script" {
  template = file("./modules/k8s-worker/init-worker.sh")

}

resource "aws_spot_instance_request" "k8s-worker" {
  ami = data.aws_ami.ubuntu-ami.id
  key_name = "tinh.bui"
  instance_type = var.WORKER_INSTANCE_TYPE
  subnet_id = var.SUBNET_ID
  security_groups = [aws_security_group.worker-sg.id]
  user_data = data.template_file.init_script.rendered
  tags = {
    Name = "${var.ENV}-${var.PROJECT_NAME}"
  }
  wait_for_fulfillment = true
  root_block_device {
    delete_on_termination = true
    iops                  = "3000"
    volume_size           = "50"
    volume_type           = "gp3"
  }
}
output "WORKER_IP" {
  value = aws_spot_instance_request.k8s-worker.private_ip
}