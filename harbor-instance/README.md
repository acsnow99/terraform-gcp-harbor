
# harbor-instance <br/> 

As basic as it gets in this repo, this directory has resources to set up Harbor as quickly as possible on a VM.  <br/>

##### Note: '.' represents 'harbor-instance'(this directory) in all path definitions in the tutorials. cd into 'harbor-instance' on your local machine for these tutorials <br/>

## Deploying Harbor to GCP using Terraform(requires GCP account) <br/>

Step 1: Edit './states/harbor-master.tfvars' to fit your GCP configuration <br/> <br/>

Step 2: Take a look at '/etc/hosts' and make sure you don't have any entries for the Harbor URL you chose. Multiple entries would confuse your computer later on when trying to access Harbor. Either delete existing entries or put a different URL for your Harbor instance in the .tfvars file(var.hostname). 
##### Note: the scripts that Terraform runs will make an edit to your '/etc/hosts' file. It will make a copy beforehand, so if something goes wrong with that file, the copy will be located under './hosts-copy' <br/> <br/>

Step 3: Run 'terraform init' and 'terraform apply -var-file=./states/harbor-master.tfvars'

##### Note: If Terraform gets stuck for more than 2 mins or an error occurs during the local-exec step, ctrl+C out of the terraform apply, and run bash './resources/local-setup-provisioned.sh' to re-try the local-exec step <br/> <br/>

Step 4: Attempt to access your Harbor URL from the internet
##### Note: You will need to bypass the error that will come up about an insecure https certificate. This error occurs because the cert was self-signed on the instance that was created. You can look at this code in 'resources/dockerce-harbor-master-install-V2.sh'(the script run remotely on the instance) <br/> <br/> <br/>


## Deploying to a VM outside of GCP <br/>

##### Note: I have only tested this on Ubuntu VMs <br/>

Step 1: Verify SSH access to your VM <br/> <br/>

Step 2: Choose whether to use 'resources/quick-harbor-mac-no-terraform.sh' or 'resources/quick-harbor-linux-no-terraform.sh' depending on your operating system and edit the 4 variable definitions at the beginning to fit your configuration <br/> <br/>

Step 3: Run 'bash resources/quick-harbor[...].sh' <br/> <br/>
