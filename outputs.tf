output "LocustDashboard" {
  value = "http://${module.nodes.master_ip}:8089"
}
