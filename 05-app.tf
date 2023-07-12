resource "vcd_vapp" "demo_vapp" {
  name = "Demo-app"
}

resource "vcd_vapp_org_network" "demo_vapp_org_net_edge_routed" {
  vapp_name        = vcd_vapp.demo_vapp.name
  org_network_name = data.vcd_network_routed_v2.edge_routed.name
}

data "template_file" "init" {
  template = file("scripts/install_front.sh")
}

resource "vcd_vapp_vm" "demo_vapp_front" {
  count            = 3
  vapp_name        = vcd_vapp.demo_vapp.name
  name             = "www${count.index + 1}"
  computer_name    = "www${count.index + 1}"
  description      = "Web server ${count.index + 1}"
  vapp_template_id = data.vcd_catalog_vapp_template.ubuntu_2204.id
  memory           = 1024
  cpus             = 1
  cpu_cores        = 1
  os_type          = "ubuntu64Guest"
  hardware_version = "vmx-14"

  network {
    type               = "org"
    name               = data.vcd_network_routed_v2.edge_routed.name
    ip_allocation_mode = "POOL"
  }
  customization {
    initscript          = data.template_file.init.rendered
  }
}
