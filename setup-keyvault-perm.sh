# Set environment variables
SPNAME=team4MojSP
AZURE_CLIENT_ID=$(az ad sp show --id http://${SPNAME} --query appId -o tsv)
KEYVAULT_NAME=Team4KeyVaultMoJ
KEYVAULT_RESOURCE_GROUP=teamResources
SUBID=06eb0a46-fa13-463b-93e4-96eca1947037

az keyvault set-policy -n $KEYVAULT_NAME --key-permissions get --spn $AZURE_CLIENT_ID
az keyvault set-policy -n $KEYVAULT_NAME --secret-permissions get --spn $AZURE_CLIENT_ID
az keyvault set-policy -n $KEYVAULT_NAME --certificate-permissions get --spn $AZURE_CLIENT_ID