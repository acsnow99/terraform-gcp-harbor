url="YOUR DESIRED HARBOR URL"

#set up helm
kubectl create serviceaccount --namespace kube-system tiller
kubectl create clusterrolebinding tiller-cluster-rule --clusterrole=cluster-admin --serviceaccount=kube-system:tiller
helm init --service-account tiller --upgrade

sleep 60

helm repo add nginx https://helm.nginx.com/stable
helm install --name ingress nginx/nginx-ingress 
  #--set controller.service.externalIPs=${ingress-ip} --set defaultBackend.service.externalIPs=${ingress-ip} \
  #--set controller.admissionWebhooks.service.externalIPs=${ingress-ip} --set controller.metrics.service.externalIPs=${ingress-ip}
sleep 60
ip="$(kubectl get svc ingress-nginx-ingress -o jsonpath="{.status.loadBalancer.ingress[*].ip}")"
# put the IP addr into /etc/hosts as core.harbor.domain
sudo cp /etc/hosts ./hosts-copy
echo "$ip $url" | sudo tee -a /etc/hosts


#start Harbor on the cluster
helm repo add harbor https://helm.goharbor.io
helm install --name harbor harbor/harbor --set expose.ingress.hosts.core=$url --set externalURL=https://$url 

sleep 180

# access online portal, download cert, and put it into keychain(or possibly the Docker certs.d directory; will be tested)
curl -k -o ca.crt https://$url/api/systeminfo/getcert
# Refresh the list of certificates to trust
sudo update-ca-certificates
# Restart the Docker daemon
sudo service docker restart

sudo cp /etc/hosts ./hosts-copy
echo "$ip $url" | sudo tee -a /etc/hosts

sleep 60

# login to docker and push a test image
sudo docker login --username admin --password Harbor12345 $url
sudo docker pull hello-world
sudo docker tag hello-world:latest $url/library/hello-world:latest
sudo docker push $url/library/hello-world:latest