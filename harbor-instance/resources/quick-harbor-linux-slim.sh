ip=${host-ip}
user=${user}
privatekey=${private-key-path}
hostname=${hostname}

# get the cert from the instance
scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -v $user@$ip:~/ca.crt .
# Refresh the list of certificates to trust
mkdir /etc/docker/certs.d/$hostname
mv ca.crt /etc/docker/certs.d/$hostname/ca.crt

echo "$ip $hostname" >> /etc/hosts

# Restart the Docker daemon
service docker restart

sleep 60

# login to docker and push a test image
docker login --username admin --password Harbor12345 $hostname
docker pull hello-world
docker tag hello-world:latest $hostname/library/hello-world:latest
docker push $hostname/library/hello-world:latest