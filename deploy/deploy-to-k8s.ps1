$scriptPath = split-path -parent $MyInvocation.MyCommand.Definition
Write-Host $scriptPath

$ttnamespace = kubectl.exe get namespaces | Select-String "technical-test" | Out-String

#Create namespace if doesn't exist
if ( ! $ttnamespace )
{
    kubectl.exe create -f $scriptPath\technical-test-namespace.yaml
    kubectl.exe config set-context tech-test --namespace=technical-test --cluster=docker-desktop --user=docker-desktop
}
kubectl.exe config use-context tech-test
Write-Host $ttnamespace

# Deploy service and deployment
kubectl.exe apply -f $scriptPath\nodeapi-service.yaml -f $scriptPath\nodeapi-deployment.yaml