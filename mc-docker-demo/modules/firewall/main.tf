resource "google_compute_firewall" "java" {
    count = "${var.java}"

    name = "${var.instance-name}-minecraft"
    network = "${var.network}"

    allow {
        protocol = "tcp"
        ports = ["25565", "22"]
    }

}

resource "google_compute_firewall" "bedrock" {
    count = "${var.bedrock}"

    name = "${var.instance-name}-minecraft"
    network = "${var.network}"

    allow {
        protocol = "tcp"
        ports    = ["22"]
    }

    allow {
        protocol = "udp"
        ports = ["19132"]
    }

}
