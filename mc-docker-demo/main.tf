provider "google" {
    credentials = "${file("${var.credentials-file}")}"
    project = "${var.project}"
    region = "${var.region}"
    zone = "${var.region}-a"
}



module "compute_instance" {
  source = "./modules/instance"

  instance-name = "${var.instance-name}"
  network = "${var.network}"
  subnet = "${var.subnet}"
  machine-type = "${var.machine-type}"
  image = "${var.image}"
  ssh-user = "${var.ssh-user}"
  ssh-public-key = "${var.ssh-public-key}"

}

module "firewall" {
  source = "./modules/firewall"

  instance-name = "${var.instance-name}"
  network = "${var.network}"

  java = "${var.java}"
  bedrock = "${var.bedrock}"

}

module "provisioner" {
  source = "./modules/provisioner"

  region = "${var.region}"
  instance-name = "${module.compute_instance.instance-name}"
  instance-ip = "${module.compute_instance.public_ip}"
  project = "${var.project}"
  bootscript = "${var.bootscript}"
  ssh-user = "${var.ssh-user}"
  ssh-private-key = "${var.ssh-private-key}"


  java = "${var.java}"
  bedrock = "${var.bedrock}"
  gamemode = "${var.gamemode}"
  worldname = "${var.worldname}"
  release = "${var.release}"
  server-type = "${var.server-type}"
  ftb-modpack = "${var.ftb-modpack}"
  exists = "${var.exists}"
  existing-world = "${var.existing-world}"
}