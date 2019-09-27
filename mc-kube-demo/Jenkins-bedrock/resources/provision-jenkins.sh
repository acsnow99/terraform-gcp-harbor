cat mc-kube-demo/Jenkins-bedrock/resources/mc-pod-jenkins.yaml | sed "s/{{RELEASE}}/$RELEASE/g" \
| sed "s/{{SERVERTYPE}}/$SERVERTYPE/g" \
| sed "s/{{MODPACK}}/$MODPACK/g" \
| sed "s,{{DOCKER_REPO}},$DOCKER_REPO,g" \
| sed "s/{{WORLDNAME}}/$WORLDNAME/g" \
| sed "s/{{GAMEMODE}}/$GAMEMODE/g" \
> mc-kube-demo/Jenkins-bedrock/resources/deployment.yaml
cat mc-kube-demo/Jenkins-bedrock/resources/pvc-jenkins.yaml > mc-kube-demo/Jenkins-bedrock/resources/pvc-deployment.yaml