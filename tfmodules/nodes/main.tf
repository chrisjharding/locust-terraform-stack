# setup rsa key for accessing
resource "aws_key_pair" "deployer" {
  key_name = "${var.name}-key"
  public_key = "${var.public_key}"
}

# setup security groups
resource "aws_security_group" "allow_all" {
  name = "allow_all"
  description = "Allow all inbound traffic"
  vpc_id = "${var.vpc_id}"

  // only a temporary stack so allow everything
  ingress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }
}

# setup master locust stack via cloudformation as we can load large files onto the instances.
resource "aws_cloudformation_stack" "master" {
  name = "${var.name}-master-stack"
  parameters {
      Locustfile = "${file("./locustfile.py")}"
      SgId = "${aws_security_group.allow_all.id}"
      KeyName = "${aws_key_pair.deployer.key_name}"
      SubnetId = "${var.subnet_id}"
      InstanceSize = "t2.micro"
      Name = "${var.name}"
      SupervisorConf = "${replace(file("./tfmodules/nodes/supervisord.conf"), "$${var.locust_command}", "${var.locust_command} --master")}"
  }
  template_body = "${file("./tfmodules/nodes/cloudformation-master.json")}"
}

# setup locust worker stack via cloudformation
resource "aws_cloudformation_stack" "workers" {
  name = "${var.name}-worker-stack"
  parameters {
      Locustfile = "${file("./locustfile.py")}"
      SgId = "${aws_security_group.allow_all.id}"
      KeyName = "${aws_key_pair.deployer.key_name}"
      SubnetId = "${var.subnet_id}"
      InstanceSize = "t2.micro"
      Name = "${var.name}"
      SupervisorConf = "${replace(file("./tfmodules/nodes/supervisord.conf"), "$${var.locust_command}", "${var.locust_command} --slave --master-host=${aws_cloudformation_stack.master.outputs["masterip"]}")}"
  }
  template_body = "${file("./tfmodules/nodes/cloudformation-workers.json")}"
}
