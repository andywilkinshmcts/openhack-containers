https://docs.microsoft.com/en-us/azure/aks/kubernetes-walkthrough

az login

az aks create -g TeamResources -n Team4AKS --node-court 3

sudo az aks install-cli

# gret credentials
az aks get-credentials --resource-group TeamResources --name Team4AKS


# connect to cluister
kubctl get nodes

az aks update -n Team4AKS -g TeamResources --attach-acr registryzyo9157

 kubectl apply -f Team4Deployment_user.yaml 
 
 kubectl get pods
 
 kubectl port-forward user-6f59895ff6-6s4jz 8888:80
 
 kubectl get deployments
 
 kubectl delete deployment userjava
 
 
