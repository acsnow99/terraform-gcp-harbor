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


Scripts are provided in all project directories for use with independent resources(your own cluster or VM) 

##### This repo is a summary of the work performed by Alex Snow during his internship project at IGNW during the summer of 2019 <br/> <br/> <br/> <br/>

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


## Guides are found in the README of each individual directory <br/> 
