# Aviatrix Spoke VCN
resource "aviatrix_vpc" "default" {
  cloud_type   = 16
  name         = "avx-${var.name}-spoke"
  region       = var.region
  cidr         = var.cidr
  account_name = var.account
}

# Single OCI Spoke Gateway 
resource "aviatrix_spoke_gateway" "spoke_gw" {
  count              = var.ha_gw ? 0 : 1
  gw_name            = "avx-${var.name}-spoke"
  vpc_id             = aviatrix_vpc.default.name
  cloud_type         = 16
  vpc_reg            = var.region
  enable_active_mesh = var.active_mesh
  gw_size            = var.instance_size
  account_name       = var.account
  subnet             = aviatrix_vpc.default.subnets[0].cidr
  transit_gw         = var.transit_gw
}

# HA OCI Spoke Gateway 
resource "aviatrix_spoke_gateway" "spoke_hagw" {
  count              = var.ha_gw ? 1 : 0
  gw_name            = "avx-${var.name}-spoke"
  vpc_id             = aviatrix_vpc.default.name
  cloud_type         = 16
  vpc_reg            = var.region
  enable_active_mesh = var.active_mesh
  gw_size            = var.instance_size
  account_name       = var.account
  subnet             = aviatrix_vpc.default.subnets[0].cidr
  ha_subnet          = aviatrix_vpc.default.subnets[0].cidr
  ha_gw_size         = var.instance_size
  transit_gw         = var.transit_gw
}