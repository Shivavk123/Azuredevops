provider "azurerm" {
    version = "3.40.0"
    features {}
}

terraform {
    backend "azurerm" {
        resource_group_name  = azurerm_resource_group.tf_test.name
        storage_account_name = azurerm_storage_account.newstorage.name
        container_name       = "tfstate"
        key                  = "terraform.tfstate"
    }
}

resource "azurerm_storage_account" "newstorage" {
  name                     = "shivastorageac"
  resource_group_name      = azurerm_resource_group.tf_test.name
  location                 = azurerm_resource_group.tf_test.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    environment = "staging"
  }
}

variable "imagebuild" {
  type        = string
  description = "Latest Image Build"
}



resource "azurerm_resource_group" "tf_test" {
  name = "tfmainrg"
  location = "Australia East"
}

resource "azurerm_container_group" "tfcg_test" {
  name                      = "weatherapi"
  location                  = azurerm_resource_group.tf_test.location
  resource_group_name       = azurerm_resource_group.tf_test.name

  ip_address_type     = "public"
  dns_name_label      = "binarythistlewa"
  os_type             = "Linux"

  container {
      name            = "weatherapi"
      image           = "shivavk12345/weatherapi:${var.imagebuild}"
        cpu             = "1"
        memory          = "1"

        ports {
            port        = 80
            protocol    = "TCP"
        }
  }
}