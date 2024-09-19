# variables.tf

variable "client_id" {
  description = "The client ID of the Azure Service Principal."
  type        = string
}

variable "client_secret" {
  description = "The client secret of the Azure Service Principal."
  type        = string
  sensitive   = true
}

variable "tenant_id" {
  description = "The tenant ID of the Azure Active Directory."
  type        = string
}

variable "subscription_id" {
  type        = string
  description = "ID of the subscription where the resource will be deployed"
}

variable "stage" {
  type        = string
  description = "Stage to be considered while clasifying the resources"
}

variable "resource_group" {
  type        = string
  description = "Name of the resource group where the resource(s) will be deployed. Changing this forces a new resource to be created. Changing this forces a new resource to be created"
  validation {
    condition     = can(regex("^[A-Za-z0-9-_]*$", var.resource_group))
    error_message = "Name should contain only letters, numbers, underscore and hyphen."
  }
}

variable "resource_name" {
  type        = string
  description = "Name of the resource to be deployed. Changing this forces a new resource to be created. Changing this forces a new resource to be created"
  validation {
    condition     = can(regex("^[A-Za-z0-9-]*$", var.resource_name))
    error_message = "Name should contain only letters, numbers and hyphen."
  }
}

variable "location" {
  type        = string
  default     = ""
  description = "Location for the resource, if empty then Resource Group location will be used. Changing this forces a new resource to be created. Changing this forces a new resource to be created"
}

variable "vnet_name" {
  type        = string
  description = "VNET where the VM will be deployed"
}

variable "subnet_name" {
  type        = string
  description = "Subnet where the VM will be deployed"
}

variable "vnet_resource_group" {
  type        = string
  description = "VNET resource group. If empty, the same RG of the new resources to be used"
  validation {
    condition     = can(regex("^[A-Za-z0-9-_]*$", var.vnet_resource_group))
    error_message = "Name should contain only letters, numbers, underscore and hyphen."
  }
}

variable "vm_size" {
    type        = string
    description = "Virtual Machine size. If empty, default to be Standard_B1s"
    default = "Standard_B1s"
}

variable "os_disk_caching" {
  description = "The caching option for the OS disk."
  type        = string
  default     = "None"
  
  validation {
    condition     = contains(["None", "ReadOnly", "ReadWrite"], var.os_disk_caching)
    error_message = "The caching option must be one of: None, ReadOnly, or ReadWrite."
  }
}

variable "os_disk_size_gb" {
  description = "The size of the OS disk in GB. Must be equal to or greater than 130 GB."
  type        = number
  default     = 130
  
  validation {
    condition     = var.os_disk_size_gb >= 130
    error_message = "The OS disk size must be at least 130 GB."
  }
}