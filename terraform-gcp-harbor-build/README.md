## terraform-gcp-harbor-build

Setting up Harbor on a single VM through a controller VM.

##### Note: This resource requires a GCP account, no matter which way it is run, since it deploys a GCP instance through Terraform on the created or existing VM. 

##### Note: '.' represents 'terraform-gcp-harbor-build'(this directory) in all path definitions in the tutorials. cd into 'terraform-gcp-harbor-build' on your local machine for these tutorials

### Deploying Harbor to a VM through a controller VM using Terraform

Step 1: Go onto GCP console, go to the 'IAM and admin' page from the sidebar, then 'service accounts'

Step 2: Create a service account with access to Compute Engine and Networking resources and download the key. Put the key somewhere safe and jot down the path to it

Step 3: Copy and edit './states/harbor-runner.tfvars' to fit your GCP configuration and the desired server setup. The 'gcp-service-key' variable will be the path to the service account key, and the credentials-file variable can be the same key or a more powerful key like your Compute Engine default service account key, which has admin access

Step 4: Copy and edit './resources/harbor-master-remote.tfvars' as well to fit your GCP configuration(this is the .tfvars file that will be used to deploy the second VM

Step 5: Run 'terraform apply -var-file=resources/{{your-file}}.tfvars'

### No method exists yet to deploy through an existing VM; I recommend SSH-ing into your VM, cloning this repo, and running the code found in '../harbor-instance'
