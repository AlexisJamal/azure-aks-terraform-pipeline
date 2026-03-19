# 1. Configuration de Terraform et des Providers
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
  skip_provider_registration = true
}

# 2. Groupe de Ressources (Le conteneur principal)
resource "azurerm_resource_group" "rg" {
  name     = "DevOps-Terraform-RG"
  location = "France Central"
}

# 3. Réseau Virtuel (VNET) et Sous-réseau (Subnet)
resource "azurerm_virtual_network" "vnet" {
  name                = "aks-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "subnet" {
  name                 = "aks-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

# 4. Azure Container Registry (ACR) - Pour tes images Docker
resource "azurerm_container_registry" "acr" {
  name                = "alexisregterraform2026"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "Basic"
  admin_enabled       = true
}

# 5. Compte de Stockage (Storage Account)
resource "azurerm_storage_account" "storage" {
  name                     = "alexisstorage2026"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# 6. Cluster AKS (Le moteur Kubernetes)
resource "azurerm_kubernetes_cluster" "aks" {
  name                = "aks-terraform-cluster"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "alexisaks"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_B2s_v2" 
    vnet_subnet_id = azurerm_subnet.subnet.id
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin     = "azure"
    service_cidr       = "10.1.0.0/16"
    dns_service_ip     = "10.1.0.10"
  }

}