# get the existing ext-net network
data "openstack_networking_network_v2" "ext_net" {
  name = "Ext-Net"
}

# create router linking to ext-net network
resource "openstack_networking_router_v2" "router_internet" {
  name        = "router-internet"
  description = "router to internet"

  external_network_id = data.openstack_networking_network_v2.ext_net.id
}

# network creation
resource "openstack_networking_network_v2" "wan_network" {
  name           = "WAN-terraform"
  admin_state_up = true
}

# subnet creation
resource "openstack_networking_subnet_v2" "wan_subnet" {
  name       = "WAN-terraform"
  network_id = openstack_networking_network_v2.wan_network.id
  cidr       = "10.2.0.0/24"
}

# create interface to link router and WAN subnet
resource "openstack_networking_router_interface_v2" "router_internet_interface" {
  router_id = openstack_networking_router_v2.router_internet.id
  subnet_id = openstack_networking_subnet_v2.wan_subnet.id
}

resource "openstack_networking_network_v2" "lan_network" { # local name used for reference
  name           = "LAN-terraform"                         # name used in ovh
  admin_state_up = true
}

resource "openstack_networking_subnet_v2" "lan_subnet" {
  name       = "LAN-terraform"
  network_id = openstack_networking_network_v2.lan_network.id
  cidr       = "172.16.2.0/24"
}
