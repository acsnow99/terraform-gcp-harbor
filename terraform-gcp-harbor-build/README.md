## terraform-gcp-harbor-build

Setting up Harbor on a single VM through a controller VM.

##### Note: This resource requires a GCP account, no matter which way it is run, since it deploys a GCP instance through Terraform on the created or existing VM. 

##### Note: '.' represents 'terraform-gcp-harbor-build'(this directory) in all path definitions in the tutorials. cd into 'terraform-gcp-harbor-build' on your local machine for these tutorials

### Deploying Harbor to a VM through a controller VM using Terraform

Step 1: Copy and edit './states/harbor-runner.tfvars' to fit your GCP configuration and the desired server setup

### Deploying through a pre-existing VM

Step 1: 
