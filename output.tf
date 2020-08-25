output "vcn" {
  description = "The full Spoke OCI VCN object"
  value       = aviatrix_vpc.default
}

output "spoke_gateway" {
  description = "The full Aviatrix OCI Spoke Gateway object"
  value       = var.ha_gw ? aviatrix_spoke_gateway.spoke_hagw[0] : aviatrix_spoke_gateway.spoke_gw[0]
}