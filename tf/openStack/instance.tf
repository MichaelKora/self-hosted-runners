variable "image_name" {
    type        = string
}

variable "flavor_name" {
    type        = string
}

variable "instance_name" {
    type        = string
}

variable "ansible_user" {
    type        = string
}

resource "openstack_compute_instance_v2" osinstance {
   name        = var.instance_name 
   provider    = openstack
   region = var.region
   image_name  = var.image_name
   flavor_name = var.flavor_name
   key_pair    = openstack_compute_keypair_v2.libvirtbuilder.name
   network {
    name      = "Ext-Net" 
   }
   metadata = {
     group = "openstack"
     ansible_user = var.ansible_user
   }
}