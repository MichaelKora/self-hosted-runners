variable "flavor_names" {
    type = list(string)
    default = ["d2-4", "d2-2", "s1-2"]
}

variable "image_names" {
  type = list(string)
  default = ["Ubuntu 21.10", "Ubuntu 21.04", "Ubuntu 20.04"]
}

variable "region" {
  type = list(string)
  default = "DE1"
 // default = ["GRA9", "DE1", "GRA9"]
}

variable "ansible_user" {
    type        = string
}

variable "server_count" {
  type = number
  default = 3
}

resource "openstack_compute_instance_v2" osinstance {
   count = var.server_count
   name        = "github-runner-${count.index}"
   provider    = openstack
   region = var.region
   image_name  = var.image_names[ count.index ]
   flavor_name = var.flavor_names[ count.index ]
   key_pair    = openstack_compute_keypair_v2.githubrunner[count.index].name
   network {
    name      = "Ext-Net"
   }
   metadata = {
     group = "openstack"
     ansible_user = var.ansible_user
   }
}
