variable "vcd_user" {
  default = "provisioner"
}
variable "vcd_pass" {
  sensitive = true
  # defined in TF_VAR_vcd_pass environment variable
}
variable "vcd_url" {
  # defined in TF_VAR_vcd_url environment variable
}
variable "vcd_org" {
  default = "TEST"
}
variable "vcd_vdc" {
  default = "VDC-TEST"
}
variable "vcd_allow_unverified_ssl" {
  default = false
}
variable "vcd_max_retry_timeout" {
  default = 60
}
