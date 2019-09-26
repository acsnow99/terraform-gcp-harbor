output "instance-name" {
    value = "${google_compute_instance.minecraft-server.name}"
}

output "public_ip" {
    value = "${google_compute_instance.minecraft-server.network_interface.0.access_config.0.nat_ip}"
}