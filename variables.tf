variable "controller_ip" {
  description = "The public IP of the Aviatrix Controller"
  type        = string
  default     = ""
}

variable "username" {
  description = "The username on the Aviatrix Controller"
  type        = string
  default     = ""
}

variable "password" {
  description = "The password of the username on the Aviatrix Controller"
  type        = string
  default     = ""
}

variable "oci_region" {
  description = "The OCI region where the Aviatrix Spoke VCN and Gateway will be provisioned in"
  type        = string
  default     = "us-ashburn-1"
}

variable "oci_spoke_cidr" {
  description = "The CIDR block of the VCN."
  type        = string
  default     = "10.3.0.0/16"
}

variable "oci_account_name" {
  description = "The OCI Access Account name defined in the Aviatrix Controller"
  type        = string
  default     = "TM-OCI"
}

variable "oci_gw_size" {
  description = "The compute instance shape size for the Aviatrix gateways"
  type        = string
  default     = "VM.Standard2.2"
}

variable "transit_gw" {
  description = "The Aviatrix Transit Gateway to attach the Spoke Gateway to"
  type        = string
  default     = ""
}

variable "ha_gw" {
    description = "Boolean to determine if module will be deployed in HA or single mode"
    type = bool
    default = true
}

