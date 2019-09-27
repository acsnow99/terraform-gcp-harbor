## terraform-gcp-harbor-build

Setting up Harbor on a Kubernetes cluster. This utilizes the Helm chart for Harbor

##### Note: '.' represents 'terraform-gcp-harbor-build'(this directory) in all path definitions in the tutorials. cd into 'terraform-gcp-harbor-build' on your local machine for these tutorials

### Deploying Harbor to GKE using Terraform(requires GCP account)

Step 1: Copy and edit './states/harbor.tfvars' to fit your GCP configuration and the desired server setup

Step 2: Run 'terraform init' and 'terraform apply -var-file=./states/{{yourfile}}.tfvars'

### Deploying to a cluster outside of GCP

Step 1: Verify that kubectl is configured to point at your desired cluster

Step 2: Edit './resources/independent-setup.sh' to fit your desired server configuration

Step 3: Run 'bash ./resources/independent-setup.sh’
