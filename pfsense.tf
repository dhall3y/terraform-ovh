resource "openstack_compute_keypair_v2" "keypair" {
  name       = "keypair"
  public_key = file("~/.ssh/main-27042025.pub") # we can use file or directly put the public key
}

data "openstack_images_image_v2" "pfsense" {
  name = "pfsense-2.7.2"
}

data "openstack_compute_flavor_v2" "pfsense-compute" {
  name = "c3-4"
}

resource "openstack_compute_instance_v2" "pfsense1" {
  count = 1
  name  = "pfsense-terraform-${count.index}"

  image_id        = data.openstack_images_image_v2.pfsense.id
  flavor_id       = data.openstack_compute_flavor_v2.pfsense-compute.id
  key_pair        = openstack_compute_keypair_v2.keypair.id
  security_groups = ["default"]
  network {
    uuid = openstack_networking_network_v2.lan_network.id # can also use name: "Name of network"
  }
  network {
    uuid = openstack_networking_network_v2.wan_network.id
  }
}

