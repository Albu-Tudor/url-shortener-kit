param location string = resourceGroup().location

var uniqueId = uniqueString(resourceGroup().id)

module apiService 'modules/compute/appservice.bicep' = {
  name: 'apiDeployments'
  params: {
    appName: 'api-${uniqueId}'
    appServiceName: 'plan-api-${uniqueId}'
    location: location
  }
}
