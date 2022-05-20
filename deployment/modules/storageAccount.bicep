@description('Name of the storage account to host the website')
param storageAccountName string

@description('Location of the storage account')
param location string = resourceGroup().location

resource storage 'Microsoft.Storage/storageAccounts@2021-09-01' = {
  name: storageAccountName
  location: location
  kind: 'StorageV2'
  sku: {
    name: 'Standard_ZRS'
  }
  properties: {
    accessTier: 'Hot'
  }
}

resource blobService 'Microsoft.Storage/storageAccounts/blobServices@2021-09-01' = {
  name: 'default'
  parent: storage
  properties: {}
}

resource websiteContainer 'Microsoft.Storage/storageAccounts/blobServices/containers@2021-09-01' = {
  name: '$web'
  parent: blobService
  properties: {
    publicAccess: 'Blob'
  }
}
