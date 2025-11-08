# # Add Cosmos DB SQL Role Assignments for current user
# data "azuread_client_config" "current" {}
# resource "azurerm_cosmosdb_sql_role_assignment" "user_cosmosdb_db_sql_role_aifp_user_thread_message_store" {
#   provider = azurerm.workload_subscription

#   depends_on = [
#     azapi_resource.ai_foundry_project_capability_host
#   ]
#   name                = uuidv5("dns","cosmosdb_operator_serthreadmessage_dbsqlrole")
#   resource_group_name = var.resource_group_name_resources
#   account_name        = azurerm_cosmosdb_account.cosmosdb.name
#   scope               = "${azurerm_cosmosdb_account.cosmosdb.id}/dbs/enterprise_memory/colls/${local.project_id_guid}-thread-message-store"
#   role_definition_id  = "${azurerm_cosmosdb_account.cosmosdb.id}/sqlRoleDefinitions/00000000-0000-0000-0000-000000000002"
#   principal_id        = data.azuread_client_config.current.object_id
# }

# resource "azurerm_cosmosdb_sql_role_assignment" "user_cosmosdb_db_sql_role_aifp_system_thread_name" {
#   provider = azurerm.workload_subscription

#   depends_on = [
#     azurerm_cosmosdb_sql_role_assignment.cosmosdb_db_sql_role_aifp_user_thread_message_store
#   ]
#   name                = uuidv5("dns","cosmosdb_operator_systemthread_dbsqlrole")
#   resource_group_name = var.resource_group_name_resources
#   account_name        = azurerm_cosmosdb_account.cosmosdb.name
#   scope               = "${azurerm_cosmosdb_account.cosmosdb.id}/dbs/enterprise_memory/colls/${local.project_id_guid}-system-thread-message-store"
#   role_definition_id  = "${azurerm_cosmosdb_account.cosmosdb.id}/sqlRoleDefinitions/00000000-0000-0000-0000-000000000002"
#   principal_id        = data.azuread_client_config.current.object_id
# }

# resource "azurerm_cosmosdb_sql_role_assignment" "user_cosmosdb_db_sql_role_aifp_entity_store_name" {
#   provider = azurerm.workload_subscription

#   depends_on = [
#     azurerm_cosmosdb_sql_role_assignment.cosmosdb_db_sql_role_aifp_system_thread_name
#   ]
#   name                = uuidv5("dns","cosmosdb_operator_entitystore_dbsqlrole")
#   resource_group_name = var.resource_group_name_resources
#   account_name        = azurerm_cosmosdb_account.cosmosdb.name
#   scope               = "${azurerm_cosmosdb_account.cosmosdb.id}/dbs/enterprise_memory/colls/${local.project_id_guid}-agent-entity-store"
#   role_definition_id  = "${azurerm_cosmosdb_account.cosmosdb.id}/sqlRoleDefinitions/00000000-0000-0000-0000-000000000002"
#   principal_id        = data.azuread_client_config.current.object_id
# }