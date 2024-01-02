# Description: This file contains the variables for the nvet module
variable "project" {
  description = "The name of the project"
  type        = string
  default     = "Synodus"
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}
variable "address_space" {
  description = "The address space for the virtual network"
  type        = list(string)
}
variable "address_prefix_public" {
  description = "The address prefix for the public subnet"
  type        = string
}
variable "address_prefix_private" {
  description = "The address prefix for the private subnet"
  type        = string
  
}

variable "location" {
  description = "The location of the resources"
  type        = string
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "security_rules_public" {
  description = "A map of tags to add to all resources"
  type        = list(object({
    name                     = string
    priority                 = number
    direction                = string
    access                   = string
    protocol                 = string
    source_port_range        = string
    destination_port_range   = string
    source_address_prefix    = string
    destination_address_prefix = string
  }))
  default = []
}


variable "security_rules_private" {
  description = "A map of tags to add to all resources"
  type        = list(object({
    name                     = string
    priority                 = number
    direction                = string
    access                   = string
    protocol                 = string
    source_port_range        = string
    destination_port_range   = string
    source_address_prefix    = string
    destination_address_prefix = string
  }))
  default = []
}


variable "security_rules_paas" {
  description = "Security rules for the PaaS network security group"
  type        = list(object({
    name                     = string
    priority                 = number
    direction                = string
    access                   = string
    protocol                 = string
    source_port_range        = string
    destination_port_range   = string
    source_address_prefix    = string
    destination_address_prefix = string
  }))
  default = []
}