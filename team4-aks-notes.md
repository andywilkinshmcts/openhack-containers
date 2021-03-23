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
 
 
####### Challenge3 - RBAC setup

# create a res group
az ad group create --display-name team4AKSAdminGroup --mail-nickname team4AKSAdminGroup
# find if resource group is created okay?
az ad group list --filter "displayname eq 'team4AKSAdminGroup'" -o table
# create a cluster
az aks create -g teamResources -n Team4AKSRBAC --enable-aad --aad-admin-group-object-ids be864619-cf32-463d-9048-a7e64f9270f4 --aad-tenant-id b40dc1a2-7266-4225-8c82-99ef76fb714b --aci-subnet-name team4-subnet