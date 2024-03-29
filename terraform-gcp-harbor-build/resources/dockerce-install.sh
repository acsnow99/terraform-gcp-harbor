sudo apt-get update -y
sudo apt-get install -y chrony dnsmasq dnsutils jq
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update -y
sudo apt-get install -y docker-ce docker-ce-cli containerd.io
sudo docker run hello-world
# install docker compose
sudo curl -L --fail https://github.com/docker/compose/releases/download/1.24.0/run.sh -o /usr/local/bin/docker-compose
# executable permissions for compose
sudo chmod +x /usr/local/bin/docker-compose

# generate ssh keys for the new instance
cd ~/.ssh
ssh-keygen -t rsa -N "" -f ~/.ssh/id_rsa
#sudo chown alexsnow: ~/.ssh/id_rsa*

# get terraform
cd
sudo apt-get install unzip
wget https://releases.hashicorp.com/terraform/0.12.4/terraform_0.12.4_linux_amd64.zip
unzip terraform_0.12.4_linux_amd64.zip
sudo mv terraform /usr/local/bin/

# start running commands based on the terraform scripts on github
cd ~/terraform_harbor
git clone https://github.com/acsnow99/terraform-gcp-harbor.git
cd terraform-gcp-harbor/harbor-instance
cp /tmp/harbor-master-remote.tfvars ./states/harbor-master-remote.tfvars
terraform init
yes yes | terraform apply -var-file=states/harbor-master-remote.tfvars

# get the ip address from the terraform output into the rest of the script
ip=$(terraform output | tr -d "instance-ip = -")

echo "$ip core.harbor.domain" | sudo tee -a /etc/hosts

# get the cert from the instance
scp -i /home/alexsnow/.ssh/id_rsa -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -v alexsnow@$ip:~/ca.crt .
sudo mkdir /etc/docker/certs.d
sudo mkdir /etc/docker/certs.d/core.harbor.domain
sudo mv ca.crt /etc/docker/certs.d/core.harbor.domain/ca.crt

# login to docker and push a test image
sudo docker login --username admin --password Harbor12345 core.harbor.domain
sudo docker tag hello-world:latest core.harbor.domain/library/hello-world:latest
sudo docker push core.harbor.domain/library/hello-world:latest