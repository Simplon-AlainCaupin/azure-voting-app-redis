#verdocker=$((curl 'https://hub.docker.com/v2/repositories/alaincpn/voteapp/tags' | jq '."results"[0]["name"]')| sed 's/\"//g')
#echo "##vso[task.setvariable variable=verdock]$verdocker"
#echo $verdocker
#prev=$(echo $KUBE_KUBECTLOUTPUT | jq '.items[1].spec.template.spec.containers[].image' | cut -d: -f2 | sed 's/"//')
#echo $prev

versionnew=$((curl 'https://hub.docker.com/v2/repositories/alaincpn/voteapp/tags' | jq '."results"[0]["name"]')| sed 's/\"//g')
versionold=$(echo $KUBE_KUBECTLOUTPUT | jq '.items[1].spec.template.spec.containers[].image' | cut -d: -f2 | sed 's/"//')
echo "##vso[task.setvariable variable=vernew]$versionnew"
echo "##vso[task.setvariable variable=verold]$versionold"
sed -i 's/{{ version }}/'$versionnew'/g' ./app/app.yml
