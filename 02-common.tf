data "vcd_edgegateway" "edge_test" {
  name     = "vEDGE-TEST"
  org      = var.vcd_org
  vdc      = var.vcd_vdc
}

data "vcd_network_routed_v2" "edge_routed" {
  org             = var.vcd_org
  edge_gateway_id = data.vcd_edgegateway.edge_test.id
  name            = "TEST2"
}

data "vcd_catalog" "templates" {
  org  = var.vcd_org
  name = "TEST-CATALOGUE"
}

data "vcd_catalog_vapp_template" "ubuntu_2204" {
  org        = var.vcd_org
  catalog_id = data.vcd_catalog.templates.id
  name       = "ubuntu-22-04-server"
}
