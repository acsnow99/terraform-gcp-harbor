Welcome to a compilation of resources for building Harbor in various environments, including:

-GKE clusters(terraform-gcp-harbor-helm)

-GCP compute engine VMs(terraform-gcp-harbor-build/harbor-instance)

-Independent Kubernetes clusters(also terraform-gcp-harbor-helm)


There are also two options for deploying Minecraft servers automatically:

-In Kubernetes(mc-kube-demo)

-In Docker on a GCP VM(mc-docker-demo)


Dependencies:

-Google Cloud SDK(unless running on independent cluster or VM)

-Terraform

-A Google Cloud Platform project and service account key with access to it(unless running on independent cluster or VM)

-Helm