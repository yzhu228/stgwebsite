@echo off

REM deploy storage account and container
for /f %%i in ('az deployment sub create -n website.000 -f .\main.bicep -p @main.parameters.json --query "properties.parameters.storageAccountName.value" -o tsv') do set storageAccountName=%%i

echo Storage account %storageAccountName% created.

REM enable static website on the blob account
az storage blob service-properties update --account-name %storageAccountName% --static-website --404-document "error.html" --index-document "index.html"