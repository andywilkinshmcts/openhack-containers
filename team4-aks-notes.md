https://docs.microsoft.com/en-us/azure/aks/kubernetes-walkthrough

az login

az aks create -g TeamResources -n Team4AKS --node-court 3

sudo az aks install-cli

# gret credentials
az aks get-credentials --resource-group TeamResources --name Team4AKS

az aks get-credentials --resource-group TeamResources --name Team4AKSRBAC

# connect to cluister
kubctl get nodes

az aks update -n Team4AKS -g TeamResources --attach-acr registryzyo9157

kubectl apply -f Team4Deployment_user.yaml 

kubectl get pods

kubectl port-forward user-6f59895ff6-6s4jz 8888:80

kubectl get deployments

kubectl delete deployment userjava
 
 
####### Challenge3 - RBAC setup

# create a aad group
az ad group create --display-name team4AKSAdminGroup --mail-nickname team4AKSAdminGroup

# add users to the aad group using azure portal

# find if aad group is created okay?
az ad group list --filter "displayname eq 'team4AKSAdminGroup'" -o table


##### get inside a pos #######
kubectl exec -it podname /bin/bash

# get the id of the sub net
az network vnet subnet  list --resource-group teamResources --vnet-name vnet
# value of the id property for the subnet

# create a cluster
az aks create -g teamResources -n Team4AKSRBAC --enable-aad --aad-admin-group-object-ids be864619-cf32-463d-9048-a7e64f9270f4 --aad-tenant-id b40dc1a2-7266-4225-8c82-99ef76fb714b --vnet-subnet-id "/subscriptions/06eb0a46-fa13-463b-93e4-96eca1947037/resourceGroups/teamResources/providers/Microsoft.Network/virtualNetworks/vnet/subnets/team4-subnet"
# we accepted system created access rights 

# Allow cluster to pull images 
az aks update -n Team4AKSRBAC -g TeamResources --attach-acr registryzyo9157

# deploy all deployments and services via deployAll.sh script

# Test using port forwarding to pod to allow app to be accessed via localhost
 kubectl port-forward tripviewer-5496c8d888-7dfpr 8888:80

# Test using port forwarding to allow app to be accessed via localhost
kubectl port-forward tripviewer-5496c8d888-7dfpr 8888:80


# 
AKS_ID=$(az aks show \
    --resource-group teamResources \  
    --name Team4AKSRBAC \
    --query id -o tsv)

# bring the api-users group-id from the portal for use in the below command
989b8ec5-ffc7-4bc1-af5d-daea785e843a

#
az role assignment create \
  --assignee 989b8ec5-ffc7-4bc1-af5d-daea785e843a \
  --role "Azure Kubernetes Service Cluster User Role" \
  --scope $AKS_ID

# 
kubectl apply -f Team4RoleApi.yaml
kubectl apply -f Team4RoleBinding_api.yaml
kubectl apply -f Team4RoleWeb.yaml
kubectl apply -f Team4RoleBinding_web.yaml

#
az aks get-credentials --resource-group teamResources --name Team4AKSRBAC --overwrite-existing
# try accessing the pods in web namespace
kubectl get pods -n web

# try accessing the pods in api namespace
kubectl get pods -n api
-- note at this stage we must use the api dev user credentials otherwise we will hit a Forbidden exception



# az key vault creation uysing the command line
az keyvault create -n Team4KeyVaultMoJ -g teamResources --location "UK South"

# add a test secrett othge key store
az keyvault secret set --vault-name Team4KeyVaultMoJ --name secret1 --value "HelloWorld"


az keyvault secret set --vault-name Team4KeyVaultMoJ --name SQL-USER --value "sqladminzYo9157"

az keyvault secret set --vault-name Team4KeyVaultMoJ --name SQL-PASSWORD --value "cW1zk2Ev4"

kubectl create secret generic secrets-store-creds --from-literal clientid=team4Moj --from-literal clientsecret=happyWednesday -n api

kubectl create secret generic secrets-store-creds --from-literal clientid=team4Moj --from-literal clientsecret=happyWednesday -n web

az ad sp create-for-rbac --skip-assignment --name team4MojSP

az keyvault set-policy -n Team4KeyVaultMoJ --secret-permissions get --spn team4MojSP

export KEYVAULT_NAME=Team4KeyVaultMoJ

export SERVICE_PRINCIPAL_CLIENT_SECRET="$(az ad sp create-for-rbac --skip-assignment --name http://secrets-store-test --query 'password' -otsv)"

export SERVICE_PRINCIPAL_CLIENT_ID="$(az ad sp show --id http://secrets-store-test --query 'appId' -otsv)"

az keyvault set-policy -n ${KEYVAULT_NAME} --secret-permissions get --spn ${SERVICE_PRINCIPAL_CLIENT_ID}

kubectl create secret generic secrets-store-creds --from-literal clientid=${SERVICE_PRINCIPAL_CLIENT_ID} --from-literal clientsecret=${SERVICE_PRINCIPAL_CLIENT_SECRET} -n api


# Set environment variables
SPNAME=team4MojSP
AZURE_CLIENT_ID=$(az ad sp show --id http://${SPNAME} --query appId -o tsv)
KEYVAULT_NAME=Team4KeyVaultMoJ
KEYVAULT_RESOURCE_GROUP=teamResources
SUBID=06eb0a46-fa13-463b-93e4-96eca1947037

az keyvault set-policy -n $KEYVAULT_NAME --key-permissions get --spn $AZURE_CLIENT_ID
az keyvault set-policy -n $KEYVAULT_NAME --secret-permissions get --spn $AZURE_CLIENT_ID
az keyvault set-policy -n $KEYVAULT_NAME --certificate-permissions get --spn $AZURE_CLIENT_ID


# Create a namespace for your ingress resources
kubectl create namespace ingress-basic

# Add the ingress-nginx repository
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx

# Use Helm to deploy an NGINX ingress controller
helm install nginx-ingress ingress-nginx/ingress-nginx \
    --namespace ingress-basic \
    --set controller.replicaCount=3 \
    --set controller.nodeSelector."beta\.kubernetes\.io/os"=linux \
    --set defaultBackend.nodeSelector."beta\.kubernetes\.io/os"=linux \
    --set controller.admissionWebhooks.patch.nodeSelector."beta\.kubernetes\.io/os"=linux


    kubectl --namespace ingress-basic get services -o wide -w nginx-ingress-ingress-nginx-controller