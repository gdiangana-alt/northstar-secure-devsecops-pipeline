package northstar

deny contains msg if {
  some name, app in input.resource.azurerm_linux_web_app
  app.https_only != true
  msg := sprintf("Linux App Service %q must enforce HTTPS.", [name])
}

deny contains msg if {
  some name, app in input.resource.azurerm_linux_web_app
  app.site_config[0].http2_enabled != true
  msg := sprintf("Linux App Service %q must enable HTTP/2.", [name])
}

deny contains msg if {
  some name, gateway in input.resource.azurerm_application_gateway
  not gateway.firewall_policy_id
  msg := sprintf("Application Gateway %q must reference a WAF policy.", [name])
}

deny contains msg if {
  some name, gateway in input.resource.azurerm_application_gateway
  not gateway.ssl_policy
  msg := sprintf("Application Gateway %q must define an explicit TLS policy.", [name])
}

deny contains msg if {
  some name, vault in input.resource.azurerm_key_vault
  vault.rbac_authorization_enabled != true
  msg := sprintf("Key Vault %q must use Azure RBAC authorization.", [name])
}

deny contains msg if {
  some name, vault in input.resource.azurerm_key_vault
  not vault.network_acls[0].default_action == "Deny"
  msg := sprintf("Key Vault %q must deny traffic by default at the network boundary.", [name])
}
