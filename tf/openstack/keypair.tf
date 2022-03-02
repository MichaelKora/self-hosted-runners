variable "keypair_name" {
    type        = string
}

resource "openstack_compute_keypair_v2" "githubrunner" {
  provider   = openstack
  region     = var.region
  name       = "${var.keypair_name}-00"
  public_key = file("../../id_rsa.pub")
}