# Required Vars
variable "name" {
  description = "Name to assign to objects"
  type        = string
}

variable "region" {
  description = "The OCI region where the Aviatrix Spoke VCN and Gateway will be provisioned in"
  type        = string
}

variable "cidr" {
  description = "The CIDR block of the VCN."
  type        = string
}

variable "account" {
  description = "The OCI Access Account name defined in the Aviatrix Controller"
  type        = string
}

variable "transit_gw" {
  description = "The Aviatrix Transit Gateway to attach the Spoke Gateway to"
  type        = string
}

variable "instance_size" {
  description = "The compute instance shape size for the Aviatrix gateways"
  type        = string
  default     = "VM.Standard2.2"
}

variable "ha_gw" {
  description = "Boolean to determine if module will be deployed in HA or single mode"
  type        = bool
  default     = true
}

variable "active_mesh" {
  description = "Set to false to disable active mesh."
  type        = bool
  default     = true
}