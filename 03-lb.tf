resource "vcd_lb_virtual_server" "http" {
  org          = var.vcd_org
  vdc          = var.vcd_vdc
  edge_gateway = data.vcd_edgegateway.edge_test.name

  name       = "demo-lb"
  ip_address = data.vcd_edgegateway.edge_test.default_external_network_ip
  protocol   = "http"
  port       = 80

  server_pool_id = vcd_lb_server_pool.web-servers.id
}

resource "vcd_lb_service_monitor" "monitor" {
  org          = var.vcd_org
  vdc          = var.vcd_vdc
  edge_gateway = data.vcd_edgegateway.edge_test.name

  name        = "http-monitor"
  interval    = "5"
  timeout     = "20"
  max_retries = "3"
  type        = "http"
  method      = "GET"
  url         = "/"
}

resource "vcd_lb_server_pool" "web-servers" {
  org          = var.vcd_org
  vdc          = var.vcd_vdc
  edge_gateway = data.vcd_edgegateway.edge_test.name

  name                 = "web-servers"
  description          = "description"
  algorithm            = "round-robin"
  enable_transparency  = true

  monitor_id = vcd_lb_service_monitor.monitor.id

  member {
    condition       = "enabled"
    name            = "www1"
    ip_address      = "10.0.0.2"
    port            = 80
    monitor_port    = 80
    weight          = 1
  }

  member {
    condition       = "enabled"
    name            = "www2"
    ip_address      = "10.0.0.3"
    port            = 80
    monitor_port    = 80
    weight          = 2
  }

  member {
    condition       = "enabled"
    name            = "www3"
    ip_address      = "10.0.0.4"
    port            = 80
    monitor_port    = 80
    weight          = 3
  }

}

