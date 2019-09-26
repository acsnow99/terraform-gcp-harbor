region = "us-west1"

instance-name = "mc-server"

network = "minecraft"

subnet = "minecraft-1"

# your GCP service key
credentials-file = "~/terraform/terraform_keys/terraform-gcp-harbor-2-3ca67fec4859.json"

project = "terraform-gcp-harbor-2"

# machine type and OS for the server
machine-type = "n1-standard-2"
image = "ubuntu-1604-xenial-v20190617"

# script run on the new instance through ssh
bootscript = "./resources/server-setup.sh"

ssh-user = "acsnow99"
ssh-public-key = "/Users/alexsnow/.ssh/id_rsa.pub"
ssh-private-key = "/Users/alexsnow/.ssh/id_rsa"


#server variables

# set to 0 for Bedrock edition server
java = 0
# set to 1 for Bedrock edition server
bedrock = 1

# 0 or 1 for Java, 'survival' or 'creative' for Bedrock
gamemode = "creative"

worldname = "DOINGUS"

# version of Minecraft to deploy(if using Bedrock, this must be changed to 1.12.0.28 or an earlier Bedrock release)
release = "1.12.0.28"

# 0 for a new world, 1 to use a world that is on your local computer
exists = "1"
# Path to an existing world file. Point to the directory titled 'db' in the world files for bedrock
existing-world = "~/Desktop/WvvpXPNgAAA=/db"