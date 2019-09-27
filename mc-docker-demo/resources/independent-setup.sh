#!/bin/bash
# base code from https://sookocheff.com/post/bash/parsing-bash-script-arguments-with-shopts/

privatekey="YOUR SSH PRIVATE KEY; PROBABLY ~/.ssh/id_rsa"
user="SSH USERNAME"
ip="IP ADDRESS OF YOUR VM"

# set to true for Bedrock server
bedrock="false"
# 0 or 1 for Java, survival or creative for Bedrock
gamemode="0"
worldname="k8s"
release="1.14.4"
modpath=""
worldtype=DEFAULT
# URL or file path to modpack; modpack must be compatible 
# with the provided 'release' and 'servertype'
modpack=""
# accepts VANILLA, FTB, or FORGE; only for Java edition
servertype=VANILLA
# set modded to true if type is FORGE, ftb to true for FTB
modded="false"
ftb="false"


echo -e "spawn-protection=16
max-tick-time=60000
query.port=25565
generator-settings=
force-gamemode=false
allow-nether=true
gamemode="${gamemode}"
enable-query=false
player-idle-timeout=0
difficulty=1
spawn-monsters=true
op-permission-level=4
pvp=true
snooper-enabled=true
level-type="${worldtype}"
hardcore=false
enable-command-block=true
network-compression-threshold=256
max-players=20
resource-pack-sha1=
max-world-size=29999984
rcon.port=25575
server-port=25565
texture-pack=
server-ip=
spawn-npcs=true
allow-flight=false
level-name="${worldname}"
view-distance=10
displayname=Fill this in if you have set the server to public\!
resource-pack=
discoverability=unlisted
spawn-animals=true
white-list=false
rcon.password=minecraft
generate-structures=true
online-mode=true
max-build-height=256
level-seed=
use-native-transport=true
prevent-proxy-connections=false
motd=A Minecraft Server powered by Docker
enable-rcon=true" > ./resources/server.properties.provisioned


echo "sudo apt-get update -y
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

mkdir ~/minecraft || true

cp /tmp/server.properties ~/minecraft/server.properties || true


sudo docker stop mc || true
sudo docker rm mc || true
sudo docker run -d --name mc -p 25565:25565 -e EULA=TRUE -e VERSION=${release} -e TYPE=${server-type} -e FTB_SERVER_MOD=${modpack} -v ~/minecraft:/data itzg/minecraft-server

" > ./resources/minecraft-setup-provisioned.sh


if [ $bedrock = true ]
then

  echo "server.properties set at time of Docker run as environment variables" > ./resources/server.properties.provisioned

  echo "sudo apt-get update -y
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

mkdir ~/minecraft || true


sudo docker stop mc || true
sudo docker rm mc || true
sudo docker run -d --name mc -p 25565:25565 -e EULA=TRUE -e VERSION=${release} -e LEVEL_NAME=${worldname} -e GAMEMODE=${gamemode} -v ~/minecraft:/data itzg/minecraft-bedrock-server

" > ./resources/minecraft-setup-provisioned.sh

fi



scp -i $privatekey -o StrictHostKeyChecking=no resources/minecraft-setup-provisioned.sh $user@$ip:/tmp/minecraft-setup.sh
scp -i $privatekey -o StrictHostKeyChecking=no resources/server.properties.provisioned $user@$ip:/tmp/server.properties

ssh -i $privatekey -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -v $user@$ip bash /tmp/minecraft-setup.sh