// add definitions for region, project, 
// and network to match your GCP configuration
prefix = "harbor-runner"
commandfile = "./resources/dockerce-install.sh"
credentials-file = "~/terraform/terraform_keys/terraform-gcp-harbor-2-45311dea3003.json"

# this means the resulting machine will automatically run the script provided under commandfile
layer-2 = "1"

gcp-service-key = "~/Downloads/terraform-gcp-harbor-2-72245571699e.json"

project = "terraform-gcp-harbor-2"

network = "default"
subnet = "default"