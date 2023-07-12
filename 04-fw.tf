resource "vcd_nsxv_firewall_rule" "http-in" {
  org          = var.vcd_org
  vdc          = var.vcd_vdc
  edge_gateway = data.vcd_edgegateway.edge_test.name

  source {
    ip_addresses = ["any"]
  }

  destination {
    ip_addresses = ["${data.vcd_edgegateway.edge_test.default_external_network_ip}"]
  }

  service {
    protocol = "tcp"
    port     = "80"
  }
}
