terraform {
  required_providers {
    openstack = {
      source = "terraform-provider-openstack/openstack"
      version = ">= 3.0.0"
    }
  }
  required_version = ">= 0.14.0"
}
