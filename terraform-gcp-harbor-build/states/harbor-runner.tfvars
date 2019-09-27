// edit definitions for region, project, 
// and network to match your GCP configuration
prefix = "harbor-runner"
commandfile = "./resources/dockerce-install.sh"
credentials-file = "~/terraform/terraform_keys/terraform-gcp-harbor-2-45311dea3003.json"

# this means the resulting machine will automatically run the script provided under commandfile
layer-2 = "1"

gcp-service-key = "~/terraform/terraform_keys/terraform-gcp-harbor-2-45311dea3003.json"

project = "terraform-gcp-harbor-2"

network = "default"
subnet = "default"

machine = "n1-standard-2"


# ALSO CHANGE resources/harbor-master-remote.tfvars WITH THE SAME INFORMATION