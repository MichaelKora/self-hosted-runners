variable "keypair_name" {
    type        = string
}

resource "openstack_compute_keypair_v2" "githubrunner" {
  count = var.server_count
  provider   = openstack
  region     = var.region
  name       = "${var.keypair_name}-${count.index}"
  public_key = file("../../id_rsa.pub")
}