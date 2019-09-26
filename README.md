<pre>

# **Deployment of Harbor through Terraform on GCP**

This project's purpose was to deploy Harbor Image Registry in GCP using compute instances and Kubernetes clusters. 

Below is a list of the environments I succeeded in deploying Harbor to, and their corresponding directories in this repo:

-GKE clusters(terraform-gcp-harbor-helm)

-Independent Kubernetes clusters(also terraform-gcp-harbor-helm)

-Stand-alone compute instance(harbor-instance)

-Compute instance set up by another compute instance in order to provide a level of separation from the user(terraform-gcp-harbor-build)


The other part of this project was automating the deployment of Minecraft servers using Docker and Kubernetes, with some integration with Harbor(as a demo of Harbor's functionalities).

Below is a list of the environments I succeeded in deploying Minecraft servers to, and their corresponding directories in this repo:

-Kubernetes(mc-kube-demo)

-Docker on a compute instance(mc-docker-demo)


Scripts are provided in all project directories for use with independent resources(your own cluster or VM)



## **Getting Started**

### **Dependencies:**

###### For all Harbor-related resources and mc-docker-demo:
-Docker

###### For all Kubernetes-related resources:
-kubectl(configured to your cluster if not created by the provided scripts)

###### Unless running on a cluster or VM independent of GCP:
-Google Cloud SDK

-Terraform

-A Google Cloud Platform project and service account key with access to it

###### Only for terraform-gcp-harbor-helm directory:
-Helm


<pre>
