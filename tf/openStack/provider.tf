variable "auth_url" {
    type        = string
}

variable "domain_name" {
    type        = string
    default = "default"
}

variable "user_name" {
    type        = string
    sensitive = true
}

variable "user_domain_name" {
    type        = string
    sensitive = true
}

variable "tenant_id" {
    type        = string
    sensitive = true
}

variable "tenant_name" {
    type        = string
}

variable "password" {
    type        = string
    sensitive = true
}

variable "region" {
    type        = string
}


provider "openstack" {
  auth_url    = var.auth_url
  domain_name = var.domain_name
  tenant_id = var.tenant_id
  tenant_name = var.tenant_name
  user_domain_name = var.user_domain_name
  user_name = var.user_name
  password = var.password
}


