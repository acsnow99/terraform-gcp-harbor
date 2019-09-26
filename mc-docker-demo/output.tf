output "instance-name" {
    value = "${module.compute_instance.instance-name}"
}

output "public_ip" {
    value = "${module.compute_instance.public_ip}"
}