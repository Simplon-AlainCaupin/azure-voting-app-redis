verdocker=$((curl 'https://hub.docker.com/v2/repositories/alaincpn/voteapp/tags' | jq '."results"[0]["name"]')| sed 's/\"//g')
echo "##vso[task.setvariable variable=verdock]$verdocker"
echo $verdocker
prev=$(echo $KUBE_KUBECTLOUTPUT)
echo $prev
