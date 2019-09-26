variable "instance-name" {
    default = "mc-server"
}

variable "network" {
    default = "minecraft"
}
variable "subnet" {
    default = "minecraft-1"
}

variable "machine-type" {
    default = "n1-standard-2"
}

variable "image" {
    default = "ubuntu-1604-xenial-v20190617"
}

variable "ssh-user" {
    description = "Name of the user for SSH"
}
variable "ssh-public-key" {
    description = "Public key to give the instance"
}