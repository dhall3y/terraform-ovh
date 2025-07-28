resource "openstack_compute_keypair_v2" "keypair" {
  name       = "keypair"
  public_key = file("~/.ssh/gitlab.pub") # we can use file or directly put the public key
}

data "openstack_images_image_v2" "integration_compute_image" {
  name = "Rocky Linux 9"
}

data "openstack_compute_flavor_v2" "integration_compute" {
  name = "c3-4"
}

resource "openstack_compute_instance_v2" "integration" {
  name = "integration-rocky"

  image_id = data.openstack_images_image_v2.integration_compute_image.id
  flavor_id = data.openstack_compute_flavor_v2.integration_compute.id
  key_pair = openstack_compute_keypair_v2.keypair.name
  security_groups = ["default"]
  network {
    uuid = openstack_networking_network_v2.wan_network.id
  }
}

# to attach a floating ip to an instance we need a port to attach the floatin ip to
data "openstack_networking_port_v2" "integration_compute_port" {
  device_id = openstack_compute_instance_v2.integration.id
}

resource "openstack_networking_floatingip_v2" "integration_floating_ip" {
  pool    = data.openstack_networking_network_v2.ext_net.name
  port_id = data.openstack_networking_port_v2.integration_compute_port.id
}
