# Aviatrix Spoke VCN
resource "aviatrix_vpc" "default" {
  cloud_type   = 16
  name         = local.name
  region       = var.region
  cidr         = var.cidr
  account_name = var.account
}

#OCI Spoke Gateway 
resource "aviatrix_spoke_gateway" "default" {
  gw_name            = local.name
  vpc_id             = aviatrix_vpc.default.name
  cloud_type         = 16
  vpc_reg            = var.region
  enable_active_mesh = var.active_mesh
  gw_size            = var.instance_size
  account_name       = var.account
  subnet             = aviatrix_vpc.default.subnets[0].cidr
  ha_subnet          = var.ha_gw ? aviatrix_vpc.default.subnets[0].cidr : null
  ha_gw_size         = var.ha_gw ? var.instance_size : null
  transit_gw         = var.transit_gw
}