# Terraform Aviatrix OCI Spoke

# This module will be deprecated in favor of the new multi-cloud spoke module
The Multi-Cloud can be found here: https://registry.terraform.io/modules/terraform-aviatrix-modules/mc-spoke/aviatrix/latest
This legacy module will remain available in the Terraform registry and on Github for the forseable future, but please plan to replace any usage of it with the multi-cloud spoke module.
This module will no longer be maintained and updated.

### Description
This module deploys a VCN, an Aviatrix spoke gateway, and attaches it to an Aviatrix Transit gateway. Defining the Aviatrix Terraform provider is assumed upstream and is not part of this module.

**_OCI Regions containing multiple Availabilty Domains_** ```us-ashburn-1, us-phoenix-1, uk-london-1, eu-frankfurt-1```

### Compatibility
Module version | Terraform version | Controller version | Terraform provider version
:--- | :--- | :--- | :---
v4.0.6 | 0.13, 0.14, 0.15 | >=6.4 | 2.19.5
v4.0.5 | 0.13, 0.14, 0.15 | >=6.4 | 2.19.5
v4.0.3 | 0.13,0.14 | >=6.4 | >=0.2.19
v4.0.2 | 0.13,0.14 | >=6.4 | >=0.2.19
v4.0.1 | 0.13,0.14 | >=6.4 | >=0.2.19
v3.0.0 | 0.13 | >=6.2 | >=0.2.17
v2.0.0 | 0.12 | >=6.2 | >=0.2.17
v1.1.1 | 0.12 | | 
v1.1.0 | 0.12 | | 
v1.0.2 | 0.12 | | 
v1.0.1 | 0.12 | |
v1.0.0 | 0.12 | |

### Diagram
<img src="https://github.com/terraform-aviatrix-modules/terraform-aviatrix-oci-spoke/blob/master/img/oci-spoke-ha.png?raw=true"  height="250">

with ha_gw set to false, the following will be deployed:

<img src="https://github.com/terraform-aviatrix-modules/terraform-aviatrix-oci-spoke/blob/master/img/oci-spoke-single.png?raw=true" height="250">

### Usage Example

```
# OCI Spoke Module
module "oci_spoke_1" {
  source         = "terraform-aviatrix-modules/oci-spoke/aviatrix"
  version        = "4.0.6"

  name           = "my-oci-spoke"
  cidr           = "10.3.0.0/16"
  region         = "us-ashburn-1"
  account        = "OCI"
  transit_gw     = "avx-transit1-transit"
  security_domain = "blue"  
}
```

The following variables are required:

key | value
--- | ---
name | avx-\<name\>-spoke
region | OCI region to deploy the spoke VCN and gateway
account | The OCI account name on the Aviatrix controller, under which the controller will deploy this VCN
cidr | The IP CIDR wo be used to create the VCN

The following variables are optional:

key | default | value
--- | --- | ---
instance_size | VM.Standard2.2 | Size of the spoke gateway instances
ha_gw | true | Builds spoke gateways with HA by default
active_mesh | true | Set to false to disable active_mesh
prefix | true | Boolean to enable prefix name with avx-
suffix | true | Boolean to enable suffix name with -spoke
attached | true | Set to false if you don't want to attach spoke to transit.
security_domain | | Provide security domain name to which spoke needs to be deployed. Transit gateway must be attached and have segmentation enabled.
single_az_ha | true | Set to false if Controller managed Gateway HA is desired
single_ip_snat | false | Specify whether to enable Source NAT feature in single_ip mode on the gateway or not. Please disable AWS NAT instance before enabling this feature. Currently only supports AWS(1) and AZURE(8)
transit_gw | The name of the Aviatrix Transit gateway to attach the spoke
customized_spoke_vpc_routes | | A list of comma separated CIDRs to be customized for the spoke VPC routes. When configured, it will replace all learned routes in VCN routing tables, including RFC1918 and non-RFC1918 CIDRs. Example: 10.0.0.0/116,10.2.0.0/16
filtered_spoke_vpc_routes | | A list of comma separated CIDRs to be filtered from the spoke VPC route table. When configured, filtering CIDR(s) or it’s subnet will be deleted from VPC routing tables as well as from spoke gateway’s routing table. Example: 10.2.0.0/116,10.3.0.0/16
included_advertised_spoke_routes | | A list of comma separated CIDRs to be advertised to on-prem as Included CIDR List. When configured, it will replace all advertised routes from this VPC. Example: 10.4.0.0/116,10.5.0.0/16
enable_private_vpc_default_route | false| Program default route in VPC private route table
enable_skip_public_route_table_update| false | Skip programming VPC public route table
enable_auto_advertise_s2c_cidrs | false | Auto Advertise Spoke Site2Cloud CIDRs
insane_mode | false | Set to true for insane mode encryption
attached_gw_egress | true | Set to false if you don't want to attach spoke to transit_gw2
transit_gw_egress| | Name of the transit gateway to attach this spoke to
transit_gw_route_tables | [] | Route tables to propagate routes to for transit_gw attachment
transit_gw_egress_route_tables | [] | Route tables to propagate routes to for transit_gw_egress attachment
private_vpc_default_route | false | Program default route in VPC private route table
skip_public_route_table_update | false | Skip programming VPC public route table
auto_advertise_s2c_cidrs | false | Auto Advertise Spoke Site2Cloud CIDRs
tunnel_detection_time | | The IPsec tunnel down detection time for the Spoke Gateway in seconds. Must be a number in the range [20-600]
inspection | false | Set to true to enable east/west Firenet inspection. Only valid when transit_gw is East/West transit Firenet

### Outputs
This module will return the following objects:

key | description
--- | ---
[vcn](https://registry.terraform.io/providers/AviatrixSystems/aviatrix/latest/docs/resources/aviatrix_vpc) | The created VCN as an object with all of it's attributes. This was created using the aviatrix_vpc resource.
[spoke_gateway](https://registry.terraform.io/providers/AviatrixSystems/aviatrix/latest/docs/resources/aviatrix_spoke_gateway) | The created Aviatrix spoke gateway as an object with all of it's attributes.


