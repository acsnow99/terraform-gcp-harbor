ip=${host-ip}
user=${user}
privatekey=${private-key-path}
hostname=${hostname}

# get the cert from the instance
scp -i $privatekey -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -v $user@$ip:~/ca.crt .

# trust the cert
sudo mkdir ~/.docker/certs.d
sudo mkdir ~/.docker/certs.d/$hostname
sudo mv ca.crt ~/.docker/certs.d/$hostname/ca.crt


sudo cp /etc/hosts ./hosts-copy
echo "$ip ${hostname}" | sudo tee -a /etc/hosts

killall Docker && open /Applications/Docker.app

sleep 60

# login to harbor through docker and push a test image
sudo docker login --username admin --password Harbor12345 $hostname
sudo docker pull hello-world
sudo docker tag hello-world:latest $hostname/library/hello-world:latest
sudo docker push $hostname/library/hello-world:latest