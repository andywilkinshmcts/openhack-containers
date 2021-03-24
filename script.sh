export KEYVAULT_NAME=Team4KeyVaultMoJ

export SERVICE_PRINCIPAL_CLIENT_SECRET="$(az ad sp create-for-rbac --skip-assignment --name http://secrets-store-test --query 'password' -otsv)"

export SERVICE_PRINCIPAL_CLIENT_ID="$(az ad sp show --id http://secrets-store-test --query 'appId' -otsv)"

az keyvault set-policy -n ${KEYVAULT_NAME} --secret-permissions get --spn ${SERVICE_PRINCIPAL_CLIENT_ID}
