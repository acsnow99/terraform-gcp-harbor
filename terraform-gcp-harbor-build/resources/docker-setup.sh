# script to automatically set up a Harbor instance you can push images to

# CHANGE THESE
user="alexsnow"

yes yes | terraform apply -var-file=states/harbor-runner.tfvars

# get the ip address from the terraform output into the rest of the script
ip=$(terraform output | tr -d "instance-ip = -")

# get the cert from the instance(on Mac)
scp -i /home/alexsnow/.ssh/id_rsa -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -v $user@$ip:~/terraform_harbor/terraform-gcp-harbor-instance/ip.txt .
ip2=$(cat ip.txt)
scp -i /home/alexsnow/.ssh/id_rsa -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -v $user@$ip:/etc/docker/certs.d/$ip2/ca.crt .

sudo mkdir ~/.docker/certs.d/$ip2
sudo mv ca.crt ~/.docker/certs.d/$ip2/ca.crt

killall Docker && open /Applications/Docker.app

sleep 60

# login to docker and push a test image
sudo docker login --username admin --password Harbor12345 $ip2
sudo docker tag busybox $ip2/library/busybox
sudo docker push $ip2/library/busybox
