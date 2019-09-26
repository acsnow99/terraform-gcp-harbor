data "template_file" "bootscript" {
    template = "${file("${var.bootscript}")}"
    
    vars = {
        docker-image = "${lookup("${var.docker-image}", "${var.java}")}"
        #${lookup("${var.docker-image}", "${var.java}")}
        release = "${var.release}"
        server-type = "${var.server-type}"
        ftb-modpack = "${var.ftb-modpack}"
    }
}

data "template_file" "server-properties" {
    template = "${file("${lookup("${var.properties-file}", "${var.java}")}")}"
    
    vars = {
        worldname = "${var.worldname}"
        gamemode = "${var.gamemode}"
    }
}

data "template_file" "world-setup" {
    template = "${file("${lookup("${var.world-setup-file}", "${var.java}")}")}"

    vars = {
        worldname = "${var.worldname}"
    }
}



resource "null_resource" "provision-files" {

    provisioner "local-exec" {
        command = "echo '${data.template_file.bootscript.rendered}' > ./resources/boot-script-provisioned.sh"
    }


    provisioner "local-exec" {
        command = "echo '${data.template_file.server-properties.rendered}' > ./resources/server.properties.provisioned"
    }

    provisioner "local-exec" {
        command = "echo '${data.template_file.world-setup.rendered}' > ./resources/world-setup-provisioned.sh"
    }

}



resource "null_resource" "add-world" {

# copies over existing world files

    count = "${var.exists}"

    depends_on = [null_resource.provision-files]

    connection {
            type = "ssh"
            host = "${var.instance-ip}"
            user = "${var.ssh-user}"
            private_key = "${file("${var.ssh-private-key}")}"
    }

    provisioner "file" {
        source = "${var.existing-world}"
        destination = "/tmp/db"
    }

}

resource "null_resource" "world-setup" {

# sets up directory for the Minecraft server so the world files are accepted correctly by the Docker container

    count = "${var.exists}"

    depends_on = ["null_resource.add-world", "null_resource.install-dependencies"]

    connection {
            type = "ssh"
            host = "${var.instance-ip}"
            user = "${var.ssh-user}"
            private_key = "${file("${var.ssh-private-key}")}"
    }

    provisioner "file" {
        source = "./resources/world-setup-provisioned.sh"
        destination = "/tmp/world-setup-provisioned.sh"
    }

    provisioner "remote-exec" {
        inline = [
            "sudo bash /tmp/world-setup-provisioned.sh",
        ]
    }

}


resource "null_resource" "install-dependencies" {

# the script provided from "var.bootscript" is run here
# the default script installs Docker, sets up a directory to volume mount, and starts the container
# from the itzg/minecraft-server or itzg/minecraft-bedrock-server image

    depends_on = [null_resource.provision-files]

    connection {
            type = "ssh"
            host = "${var.instance-ip}"
            user = "${var.ssh-user}"
            private_key = "${file("${var.ssh-private-key}")}"
    }
    provisioner "file" {
        source = "./resources/boot-script-provisioned.sh"
        destination = "/tmp/run-command.sh"
    }
    provisioner "file" {
        source = "./resources/server.properties.provisioned"
        destination = "/tmp/server.properties"
    }
    provisioner "remote-exec" {
        inline = [
            "sudo chmod 755 /tmp/run-command.sh",
            "sudo bash /tmp/run-command.sh",
        ]
    }
}

resource "null_resource" "cleanup" {
    depends_on = [null_resource.install-dependencies]

    provisioner "local-exec" {
        command = "rm ./resources/server.properties.provisioned ./resources/boot-script-provisioned.sh"
    }
}