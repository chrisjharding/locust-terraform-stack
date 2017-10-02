output "master_ip" {
  value = "${aws_instance.master.public_ip}"
}

output "private_key" {
  value = "${tls_private_key.temp.private_key_pem}"
}
