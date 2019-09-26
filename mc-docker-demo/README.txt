Welcome to the Minecraft on GCP suite!

If you need a VM specifically to deploy the server on, the Terraform resources provided can set up the whole
environment on GCP. Copy and edit states/default.tfvars to include your specific
GCP service key, the project and network that the cluster will deploy to, and
the configuration for the Minecraft server. 
Then run "terraform apply -var-file=states/{your file}" to set up the entire environment.

