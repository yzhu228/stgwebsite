targetScope = 'subscription'

@description('Name of resource group in which the website is hosted')
param resourceGroupName string

@description('Name of the storage account to host the website')
param storageAccountName string

param location string

resource resGroup 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: resourceGroupName
  location: location
}

module storageAccountMod 'modules/storageAccount.bicep' = {
  name: 'storageAccountMod'
  scope: resGroup
  params: {
    storageAccountName: storageAccountName
    location: location
  }
}
