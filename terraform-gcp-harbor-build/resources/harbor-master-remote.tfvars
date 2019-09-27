## CHANGE THESE
# access key file to GCP
credentials-file = "~/terraform_harbor/terraform_key.json"

# your name, according to your ssh keys
ssh_user = "alexsnow"

# GCP project name
project = "terraform-gcp-harbor-2"

# GCP VPC and subnet inside that VPC
network = "default"
subnet = "default"

# GCP region you are in
region = "us-west1"

# URL for the Harbor instance
hostname = "core.harbor.domain"

# resources/quick-harbor-mac.sh when on mac, resources/quick-harbor-linux.sh when on Linux, 
# resources/quick-harbor-linux-slim.sh when running through a super simple 
# Linux releases(something that does not have sudo) such as certain Docker containers
local-setup = "resources/quick-harbor-mac.sh"



## NOT NECESSARY TO CHANGE
# name for the compute instance
prefix = "harbor-ubuntu-managed"

# files that will be provisioned for the instance in order to run Harbor
commandfile = "resources/dockerce-harbor-master-install-V2.sh"
configfile = "resources/harbor-master.yml"

## defaults for the compute instance
# machine type
machine = "n1-standard-2"
# OS image to use
image = "ubuntu-1604-xenial-v20190617"

# your ssh keys
ssh_public_key = "~/.ssh/id_rsa.pub"
ssh_private_key = "~/.ssh/id_rsa"