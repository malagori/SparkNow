variable name {}
variable floating_ip_pool {}
variable image_name {}
variable flavor_name {}
variable keypair_name {}

resource "openstack_compute_floatingip_v2" "master_floating_ip" {
  pool = "${var.floating_ip_pool}"
}

resource "openstack_compute_instance_v2" "instance" {
  name="${var.name}"
  image_name = "${var.image_name}"
  flavor_name = "${var.flavor_name}"
  floating_ip = "${openstack_compute_floatingip_v2.master_floating_ip.address}"
  user_data = "${file("${path.module}/bootstrap.sh")}"
  key_pair = "${var.keypair_name}"
}

output "ip_address" {
  value = "${openstack_compute_instance_v2.instance.0.network.0.fixed_ip_v4}"
}
