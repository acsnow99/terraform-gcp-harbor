# the Harbor host is itself; config file has host field set to its ip address
data "template_file" "install-config-ip" {
    
    template = "${file("${var.configfile}")}"
    
    vars = {
        hostname = "${var.hostname}"
    }
}

data "template_file" "local-setup" {
    
    template = "${file("${var.local-setup}")}"
    
    vars = {
        host-ip = "${google_compute_instance.harbor.network_interface.0.access_config.0.nat_ip}"
        user = "${var.ssh_user}"
        private-key-path = "${var.ssh_private_key}"
        hostname = "${var.hostname}"
    }
}

# Create Harbor node
resource "google_compute_instance" "harbor" {
    name = "${var.prefix}"
    machine_type = "${var.machine}"
    
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
            # nat_ip(ephemeral IP) exists here once Terraform applies
        }
    }

    metadata = {
        ssh-keys = "${var.ssh_user}:${file("${var.ssh_public_key}")}"
    }
}

# installs Harbor and the necessary tools to install it
resource "null_resource" "install-harbor" {
    
    depends_on = [google_compute_instance.harbor]

    connection {
            type = "ssh"
            host = "${google_compute_instance.harbor.network_interface.0.access_config.0.nat_ip}"
            user = "${var.ssh_user}"
            private_key = "${file("${var.ssh_private_key}")}"
    }
    provisioner "file" {
        content = "${data.template_file.install-config-ip.rendered}"
        destination = "/tmp/harbor-config.yml"
    }
    provisioner "file" {
        source = "${var.commandfile}"
        destination = "/tmp/run-command.sh"
    }
    provisioner "remote-exec" {
        inline = [
            # uses the file from the other provisioner to install docker and harbor
            "sudo chmod 755 /tmp/run-command.sh",
            "sudo /tmp/run-command.sh",
        ]
    }
}

resource "null_resource" "local-setup" {

    depends_on = [null_resource.install-harbor]

    provisioner "local-exec" {
        command = "echo '${data.template_file.local-setup.rendered}' > resources/local-setup-provisioned.sh && bash resources/local-setup-provisioned.sh"
    }

}