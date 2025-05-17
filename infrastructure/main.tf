provider "snowflake" {
  organization_name = var.snowflake_organization_name
  account_name      = var.snowflake_account_name
  user              = var.snowflake_user
  password          = var.snowflake_password
}


# Create ENGINEER_ROLE role
resource "snowflake_account_role" "engineer_role" {
  name = "ROLE_ENGINEER"
}

# Grant ALL PRIVILEGES to ROLE_ENGINEER role for the Sephora database
resource "snowflake_grant_privileges_to_account_role" "engineer_role_priviliges_db" {
  account_role_name = snowflake_account_role.engineer_role.name
  all_privileges    = true
  on_account_object {
    object_type = "DATABASE"
    object_name = snowflake_database.sephora_db.name
  }
}

# Grant ALL PRIVILEGES to ROLE_ENGINEER role for all the schemas of Sephora database
resource "snowflake_grant_privileges_to_account_role" "engineer_role_priviliges_schema" {
  account_role_name = snowflake_account_role.engineer_role.name
  all_privileges    = true
  on_schema {
    all_schemas_in_database = snowflake_database.sephora_db.name
  }
}

# Grant user to ROLE_ENGINEER role
resource "snowflake_grant_account_role" "engineer_user_grant" {
  role_name = snowflake_account_role.engineer_role.name
  user_name = var.snowflake_user
}

# Create WAREHOUSE_ENGINEER_S warehouse
resource "snowflake_warehouse" "engineer_warehouse" {
  name           = "WAREHOUSE_ENGINEER_S"
  warehouse_size = "small"
}

# Grant ALL PRIVILEGES to ROLE_ENGINEER role for the WAREHOUSE_ENGINEER_S warehouse
resource "snowflake_grant_privileges_to_account_role" "warehouse_role_privileges" {
  account_role_name = snowflake_account_role.engineer_role.name
  all_privileges    = true
  on_account_object {
    object_type = "WAREHOUSE"
    object_name = snowflake_warehouse.engineer_warehouse.name
  }
}

# Create Sephora database
resource "snowflake_database" "sephora_db" {
  name = "SEPHORA_ANALYTICS"
}
