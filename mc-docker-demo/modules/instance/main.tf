resource "google_compute_instance" "minecraft-server" {
    name = "${var.instance-name}"

    machine_type = "${var.machine-type}"
    allow_stopping_for_update = "true"
    boot_disk {
         initialize_params {
             image =  "${var.image}"
         }
    }

    network_interface {
        network = "${var.network}"
        subnetwork = "${var.subnet}"
        access_config {
            # nat_ip is here
        }
    }

    metadata = {
        ssh-keys = "${var.ssh-user}:${file("${var.ssh-public-key}")}"
    }
}