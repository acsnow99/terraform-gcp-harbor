## mc-kube-demo

Setting up a simple Minecraft server on a Kubernetes cluster. This utilizes the Docker image itzg/minecraft-server and the additional itzg/minecraft-bedrock-server for players that do not use Java edition

##### Note: '.' represents 'mc-kube-demo'(this directory) in all path definitions in the tutorials. cd into 'mc-kube-demo' on your local machine for these tutorials

### Deploying Minecraft to GKE using Terraform(requires GCP account)

Step 1: Copy and edit './states/default.tfvars' to fit your GCP configuration and the desired server setup

Step 2: Run 'terraform init' and 'terraform apply -var-file=./states/{{yourfile}}.tfvars'

Step 3: Note down the value of 'instance-ip' at the end of the Terraform output

Step 4: Boot up the corresponding version of Minecraft, click 'multiplayer', then 'direct connect', and enter the IP address of the server <br/>


### Deploying to a VM outside of GCP

##### Note: I have only tested this on Ubuntu VMs

Step 1: Verify that kubectl is configured to point at your desired cluster

Step 2: Edit './resources/independent-setup.sh' to fit your desired server configuration

Step 3: Run 'bash ./resources/independent-setup.sh’
