param location string = resourceGroup().location
param appServiceName string
param appName string

resource appServicePlan 'Microsoft.Web/serverfarms@2024-04-01' = {
  kind: 'linux'
  location: location
  name: appServiceName
  properties: {
    reserved: true
  }
  sku: {
    name: 'B1'
  }
}

resource webApi 'Microsoft.Web/sites@2024-04-01' = {
  name: appName
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
    siteConfig: {
      linuxFxVersion: 'DOTNETCORE|8.0'
    }
  }
}

resource webAppConfig 'Microsoft.Web/sites/config@2024-04-01' = {
  parent: webApi
  name: 'web'
  properties: {
    scmType: 'GitHub'
  }
}

output appServiceId string = webApi.id
