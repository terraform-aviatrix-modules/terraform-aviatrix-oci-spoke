# Terraform Aviatrix OCI Spoke

### Description

This module deploys a VCN, an Aviatrix spoke gateway, and attaches it to an Aviatrix Transit gateway. Defining the Aviatrix Terraform provider is assumed upstream and is not part of this module.

### Diagram

<img src="https://avtx-tf-modules-images.s3.amazonaws.com/transit-vcn-oci.png"  height="250">

### Usage Example

```
# OCI Spoke Module
module "oci_spoke_1" {
  source         = "terraform-aviatrix-modules/oci-spoke/aviatrix"
  version        = "1.0.1"
  cidr           = "10.3.0.0/16"
  region         = "us-ashburn-1"
  account        = "TM-OCI"
}
```

The following variables are required:

key | value
--- | ---
name | Provide a name for VPC and Gateway resources. Result will be avx-\<name\>-spoke.
region | OCI region to deploy the spoke VCN and gateway
account | The OCI account name on the Aviatrix controller, under which the controller will deploy this VCN
cidr | The IP CIDR wo be used to create the VCN
transit_gw | The name of the Aviatrix Transit gateway to attach the spoke

The following variables are optional:

key | default | value
--- | --- | ---
instance_size | VM.Standard2.2 | Size of the spoke gateway instances
ha_gw | true | Builds spoke gateways with HA by default

Outputs
This module will return the following objects:

key | description
--- | ---
vcn | The created vcn as an object with all of it's attributes. This was created using the aviatrix_vpc resource.
spoke_gateway | The created Aviatrix spoke gateway as an object with all of it's attributes.

