ip="IP ADDRESS OF THE VM"
user="SSH USER"
privatekey="SSH PRIVATE KEY; PROBABLY ~/.ssh/id_rsa"
hostname="URL FOR THE NEW HARBOR INSTALLATION"


echo "# Configuration file of Harbor

# The IP address or hostname to access admin UI and registry service.
# DO NOT use localhost or 127.0.0.1, because Harbor needs to be accessed by external clients.
hostname: ${hostname}

# http related config
http:
  # port for http, default is 80. If https enabled, this port will redirect to https port
  port: 80

# https related config
https:
#   # https port for harbor, default is 443
  port: 443
   # The path of cert and key files for nginx
  certificate: /etc/ssl/certs/harbor.gcp.crt
  private_key: /etc/ssl/certs/harbor.gcp.key

# Uncomment external_url if you want to enable external proxy
# And when it enabled the hostname will no longer used
# external_url: https://reg.mydomain.com:8433

# The initial password of Harbor admin
# It only works in first time to install harbor
# Remember Change the admin password from UI after launching Harbor.
harbor_admin_password: Harbor12345

# Harbor DB configuration
database:
  # The password for the root user of Harbor DB. Change this before any production use.
  password: root123

# The default data volume
data_volume: /data

# Harbor Storage settings by default is using /data dir on local filesystem
# Uncomment storage_service setting If you want to using external storage
# storage_service:
#   # ca_bundle is the path to the custom root ca certificate, which will be injected into the truststore
#   # of registry's and chart repository's containers.  This is usually needed when the user hosts a internal storage with self signed certificate.
#   ca_bundle:

#   # storage backend, default is filesystem, options include filesystem, azure, gcs, s3, swift and oss

#   # for more info about this configuration please refer https://docs.docker.com/registry/configuration/
#   filesystem:
#     maxthreads: 100
#   # set disable to true when you want to disable registry redirect
#   redirect:
#     disabled: false

# Clair configuration
clair:
  # The interval of clair updaters, the unit is hour, set to 0 to disable the updaters.
  updaters_interval: 12

  # Config http proxy for Clair, e.g. http://my.proxy.com:3128
  # Clair doesn't need to connect to harbor internal components via http proxy.
  http_proxy:
  https_proxy:
  no_proxy: 127.0.0.1,localhost,core,registry

jobservice:
  # Maximum number of job workers in job service
  max_job_workers: 10

chart:
  # Change the value of absolute_url to enabled can enable absolute url in chart
  absolute_url: disabled

# Log configurations
log:
  # options are debug, info, warning, error, fatal
  level: info
  # Log files are rotated log_rotate_count times before being removed. If count is 0, old versions are removed rather than rotated.
  rotate_count: 50
  # Log files are rotated only if they grow bigger than log_rotate_size bytes. If size is followed by k, the size is assumed to be in kilobytes.
  # If the M is used, the size is in megabytes, and if G is used, the size is in gigabytes. So size 100, size 100k, size 100M and size 100G
  # are all valid.
  rotate_size: 200M
  # The directory on your host that store log
  location: /var/log/harbor

#This attribute is for migrator to detect the version of the .cfg file, DO NOT MODIFY!
_version: 1.8.0

# Uncomment external_database if using external database.
# external_database:

#   harbor:
#     host: harbor_db_host
#     port: harbor_db_port
#     db_name: harbor_db_name
#     username: harbor_db_username
#     password: harbor_db_password
#     ssl_mode: disable
#   clair:
#     host: clair_db_host
#     port: clair_db_port
#     db_name: clair_db_name
#     username: clair_db_username
#     password: clair_db_password
#     ssl_mode: disable
#   notary_signer:
#     host: notary_signer_db_host
#     port: notary_signer_db_port
#     db_name: notary_signer_db_name
#     username: notary_signer_db_username
#     password: notary_signer_db_password
#     ssl_mode: disable
#   notary_server:
#     host: notary_server_db_host
#     port: notary_server_db_port
#     db_name: notary_server_db_name
#     username: notary_server_db_username
#     password: notary_server_db_password
#     ssl_mode: disable

# Uncomment external_redis if using external Redis server
# external_redis:
#   host: redis
#   port: 6379
#   password:
#   # db_index 0 is for core, it's unchangeable
#   registry_db_index: 1
#   jobservice_db_index: 2
#   chartmuseum_db_index: 3

# Uncomment uaa for trusting the certificate of uaa instance that is hosted via self-signed cert.
# uaa:
#   ca_file: /path/to/ca" > resources/harbor-config-provisioned.yml

scp -i $privatekey -o StrictHostKeyChecking=no resources/harbor-config-provisioned.yml $user@$ip:/tmp/harbor-config.yml


echo "sudo apt-get update -y
sudo apt-get install -y chrony dnsmasq dnsutils jq
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu lsb_release -cs stable"
sudo apt-get update -y
sudo apt-get install -y docker-ce docker-ce-cli containerd.io
sudo docker run hello-world
# install docker compose
sudo curl -L --fail https://github.com/docker/compose/releases/download/1.24.0/run.sh -o /usr/local/bin/docker-compose
# executable permissions for compose
sudo chmod +x /usr/local/bin/docker-compose

openssl req -newkey rsa:4096 -nodes -sha256 -keyout ca.key -x509 -days 3650 -out ca.crt -subj "/C=US/ST=Oregon/L=Portland/0=IGNW/OU=Devops/CN=$hostname"
openssl req -newkey rsa:4096 -nodes -sha256 -keyout harbor.gcp.key -out harbor.gcp.csr -subj "/C=US/ST=Oregon/L=Portland/0=IGNW/OU=Devops/CN=$hostname"
openssl x509 -req -days 3650 -in harbor.gcp.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out harbor.gcp.crt
sudo mkdir etc/ssl/certs
sudo cp *.crt *.key /etc/ssl/certs

wget https://storage.googleapis.com/harbor-releases/release-1.8.0/harbor-online-installer-v1.8.1.tgz
tar xvzf harbor-online-installer-v1.8.1.tgz
cp /tmp/harbor-config.yml ~/harbor/harbor.yml
sudo ~/harbor/install.sh --with-notary --with-clair" > resources/harbor-install-provisioned.sh 

scp -i $privatekey -o StrictHostKeyChecking=no resources/harbor-install-provisioned.sh $user@$ip:/tmp/harbor-install.sh

ssh -i $privatekey -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -v $user@$ip bash /tmp/harbor-install.sh


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