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
  gw_name                           = local.name
  vpc_id                            = aviatrix_vpc.default.name
  cloud_type                        = 16
  vpc_reg                           = var.region
  enable_active_mesh                = var.active_mesh
  gw_size                           = var.instance_size
  account_name                      = var.account
  subnet                            = aviatrix_vpc.default.subnets[0].cidr
  ha_subnet                         = var.ha_gw ? aviatrix_vpc.default.subnets[0].cidr : null
  ha_gw_size                        = var.ha_gw ? var.instance_size : null
  transit_gw                        = var.transit_gw
  manage_transit_gateway_attachment = false
}

resource "aviatrix_spoke_transit_attachment" "default" {
  count           = var.attached ? 1 : 0
  spoke_gw_name   = aviatrix_spoke_gateway.default.gw_name
  transit_gw_name = var.transit_gw
}

resource "aviatrix_segmentation_security_domain_association" "default" {
  count                = var.attached ? (length(var.security_domain) > 0 ? 1 : 0) : 0 #Only create resource when attached and security_domain is set.
  transit_gateway_name = var.transit_gw
  security_domain_name = var.security_domain
  attachment_name      = aviatrix_spoke_gateway.default.gw_name
  depends_on           = [aviatrix_spoke_transit_attachment.default] #Let's make sure this cannot create a race condition
}
