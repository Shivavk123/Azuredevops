provider "azurerm" {
    version = "3.39.0"
    features {}
}

resource "azurerm_resource_group"  "tf_test" {
  name =  "tfmainrg"
  location = "Australia East"

}

resource "azurerm_container_group" "tfcg_test" {
  name                      = "weatherapi"
  location                  = azurerm_resource_group.tf_test.location
  resource_group_name       = azurerm_resource_group.tf_test.name

  ip_address_type     = "Public"
  dns_name_label      = "shivavk"
  os_type             = "Linux"

  container {
      name            = "weatherapi"
      image           = "shivavk12345/weatherapi"
        cpu             = "1"
        memory          = "1"

        ports {
            port        = 80
            protocol    = "TCP"
        }
  }
}