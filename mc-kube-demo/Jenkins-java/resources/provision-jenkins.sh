cat mc-kube-demo/Jenkins-java/resources/mc-pod-jenkins.yaml | sed "s/{{RELEASE}}/$RELEASE/g" \
| sed "s/{{SERVERTYPE}}/$SERVERTYPE/g" \
| sed "s/{{MODPACK}}/$MODPACK/g" \
| sed "s,{{DOCKER_REPO}},$DOCKER_REPO,g" \
> mc-kube-demo/Jenkins-java/resources/deployment.yaml
cat mc-kube-demo/Jenkins-java/resources/pvc-jenkins.yaml > mc-kube-demo/Jenkins-java/resources/pvc-deployment.yaml
cat mc-kube-demo/Jenkins-java/resources/server.properties.jenkins | sed "s/{{WORLDNAME}}/$WORLDNAME/g" \
| sed "s/{{GAMEMODE}}/$GAMEMODE/g" \
> mc-kube-demo/Jenkins-java/resources/server.properties.provisioned