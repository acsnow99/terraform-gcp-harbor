ip=${host-ip}
user=${user}
privatekey=${private-key-path}
hostname=${hostname}

# get the cert from the instance
scp -i $privatekey -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -v $user@$ip:~/ca.crt .
# Refresh the list of certificates to trust
sudo update-ca-certificates
# Restart the Docker daemon
sudo service docker restart

sudo cp /etc/hosts ./hosts-copy
echo "$ip $hostname" | sudo tee -a /etc/hosts

sleep 60

# login to docker and push a test image
sudo docker login --username admin --password Harbor12345 $hostname
sudo docker pull hello-world
sudo docker tag hello-world:latest $hostname/library/hello-world:latest
sudo docker push $hostname/library/hello-world:latest