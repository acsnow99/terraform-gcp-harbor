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
java = 1
# set to 1 for Bedrock edition server
bedrock = 0

# 0 or 1 for Java, 'survival' or 'creative' for Bedrock
gamemode = 0

worldname = "Sigma"

# version of Minecraft to deploy(if using Bedrock, this must be changed to 1.12.0.28 or an earlier Bedrock release)
release = "1.14.4"

# supports VANILLA and FTB
server-type = "VANILLA"

# URL of modpack to install when server-type is FTB. Make sure it supports the version of Minecraft put in 'release' var
ftb-modpack = "https://www.feed-the-beast.com/projects/ftb-presents-direwolf20-1-12/files/2690320"

# 0 for a new world, 1 to use a world that is on your local computer
exists = "1"
# Path to an existing world file. Point to the directory titled 'db' in the world files for bedrock
existing-world = "~/Desktop/Sigma"