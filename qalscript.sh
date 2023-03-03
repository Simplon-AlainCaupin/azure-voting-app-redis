dockerhubversion=$((curl 'https://hub.docker.com/v2/repositories/alaincpn/voteapp/tags' | jq '."results"[0]["name"]')| sed 's/\"//g')
echo "Version sur dockerhub : "
echo $dockerhubversion

kubeoutputversion=$(echo $K8S_KUBECTLOUTPUT | jq '.items[1].spec.template.spec.containers[].image' | cut -d: -f2 | sed 's/"//')
echo "Version output kubectl : "
echo $kubeoutputversion

scriptversion=$(cat azure-vote/main.py | grep -E "^ver = \"[0-9.]+\"\$"|awk -F\" {'print $2'})
echo "Version dans le script : "
echo $scriptversion

echo "##vso[task.setvariable variable=dockversion]$dockerhubversion"
echo "##vso[task.setvariable variable=kubeoutpversion]$kubeoutputversion"
echo "##vso[task.setvariable variable=scrversion]$scriptversion"

sed -i 's/{{ version }}/'$versionnew'/g' ./app/app.yml
