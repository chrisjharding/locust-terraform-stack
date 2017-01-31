output "master_ip" {
  value = "${aws_cloudformation_stack.master.outputs["masterip"]}"
}
