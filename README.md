# Deployment of Harbor through Terraform on GCP

This project's purpose was to deploy Harbor Image Registry in GCP using compute instances and Kubernetes clusters. <br/>

Below is a list of the environments I succeeded in deploying Harbor to, and their corresponding directories in this repo: <br/>

-GKE clusters(terraform-gcp-harbor-helm) <br/>

-Independent Kubernetes clusters(also terraform-gcp-harbor-helm) <br/>

-Stand-alone compute instance(harbor-instance) <br/>

-Compute instance set up by another compute instance in order to provide a level of separation from the user(terraform-gcp-harbor-build) <br/> <br/>


The other part of this project was automating the deployment of Minecraft servers using Docker and Kubernetes, with some integration with Harbor(as a demo of Harbor's functionalities). <br/>

Below is a list of the environments I succeeded in deploying Minecraft servers to, and their corresponding directories in this repo: <br/>

-Kubernetes(mc-kube-demo) <br/>

-Docker on a compute instance(mc-docker-demo) <br/> <br/>


Scripts are provided in all project directories for use with independent resources(your own cluster or VM) <br/> <br/> <br/>



## Getting Started <br/>

### Dependencies: <br/>

###### For all Harbor-related resources and mc-docker-demo:
-Docker <br/>

###### For all Kubernetes-related resources:
-kubectl <br/>

###### Unless running on a cluster or VM independent of GCP:
-Google Cloud SDK <br/>

-Terraform <br/>

-A Google Cloud Platform project and service account key with access to it <br/>

###### Only for terraform-gcp-harbor-helm directory:
-Helm <br/>

###### If using resources independent of Terraform:
-configure kubectl to point to your cluster <br/>

-SSH access to your VM <br/> <br/>


## Guides <br/> <br/>

### harbor-instance <br/> 

As basic as it gets in this repo, this directory has resources to set up Harbor as quickly as possible on a VM.  <br/>

##### Note: '.' represents 'harbor-instance' in all path definitions in the tutorials. cd into harbor-instance for these tutorials <br/>

#### Deploying Harbor to GCP using Terraform(requires GCP account) <br/>

Step 1: Edit ./states/harbor-master.tfvars to fit your GCP configuration <br/> <br/>

Step 2: Take a look at /etc/hosts and make sure you don't have any entries for the Harbor URL you chose. Multiple entries would confuse your computer later on when trying to access Harbor. Either delete existing entries or choose a different URL for your Harbor instance in the .tfvars file. 
###### Note: the scripts that Terraform runs will make an edit to your /etc/hosts file. It will make a copy beforehand, so if something goes wrong with that file, the copy will be located under ./hosts-copy <br/> <br/>

Step 3: Run terraform apply -var-file=./states/harbor-master.tfvars

###### Note: If Terraform gets stuck for more than 2 mins or an error occurs during the local-exec step, ctrl+C out of the terraform apply, and run bash ./resources/local-setup-provisioned.sh to re-try the local-exec step <br/> <br/>

Step 4: Attempt to access your Harbor URL from the internet
###### Note: You will need to bypass the error that will come up about an insecure https certificate. This error occurs because the cert was self-signed on the instance that was created. You can look at this code in resources/dockerce-harbor-master-install-V2.sh(the script run remotely on the instance) <br/> <br/>
