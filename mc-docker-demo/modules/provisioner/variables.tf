variable "region" {
    default = "us-west1"
}
variable "instance-name" {
    default = "mc-cluster"
}
variable "instance-ip" {

}
variable "project" {
    
}
variable "bootscript" {
    default = "./resources/server-setup.sh"
}
variable "ssh-private-key" {

}
variable "ssh-user" {

}

variable "java" {
    default = "1"
}
variable "bedrock" {
    default = "0"
}

variable "gamemode" {
    description = "For a Java server: 0 for survival, 1 for creative. For Bedrock: survival or creative"
    default = "0"
}
variable "worldname" {
    description = "Name for the Minecraft world"
    default = "GKE"
}
variable "release" {
    description = "Version of minecraft to use"
    default = "1.12.2"
}
variable "server-type" {
    description = "VANILLA, FORGE, BUKKIT, SPIGOT, PAPER, FTB, CURSEFORGE, or SPONGEVANILLA"
    default = "VANILLA"
}
variable "ftb-modpack" {
    default = "https://www.feed-the-beast.com/projects/ftb-presents-direwolf20-1-12/files/2690320"
}
variable "exists" {
    default = "0"
}
variable "existing-world" {

}

variable "docker-image" {
    type = "map"
    default = {
        "0" = "itzg/minecraft-bedrock-server"
        "1" = "itzg/minecraft-server"
    }
}
variable "properties-file" {
    type = "map"
    default = {
        "0" = "./resources/bedrock.server.properties"
        "1" = "./resources/java.server.properties"
    }
}

variable "world-setup-file" {
    type = "map"
    default = {
        "0" = "./resources/bedrock-world-setup.sh"
        "1" = "./resources/java-world-setup.sh"
    }
}