output "locust_dashboard" {
  value = "http://${module.nodes.master_ip}:8089"
}

output "slave_nodes" {
  value = "${module.nodes.slave_ips}"
}

output "nodes_rsa_key" {
  value = "${module.nodes.private_key}"
}
