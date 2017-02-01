output "vpc_id" {
  value = "${aws_vpc.main.id}"
}
output "subnet_ids" {
  value = "${join(",", aws_subnet.main.*.id)}"
}
