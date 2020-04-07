// I used the following incantations to set up an service principal, afterwards instance creation 'just works':
// az login
// az account list --query "[].{name:name, subscriptionId:id, tenantId:tenantId}"
// az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/<a subscription ID>"

provider "azurerm" {
  version = "~>2.0"

  # 'feature' block is mandatory
  features {
  }
}
