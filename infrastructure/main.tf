provider "snowflake" {
  organization_name = var.snowflake_organization_name
  account_name      = var.snowflake_account_name
  user              = var.snowflake_user
  password          = var.snowflake_password
}

resource "snowflake_account_role" "engineer_role" {
  name = "ROLE_ENGINEER"
}

resource "snowflake_grant_privileges_to_account_role" "engineer_role_priviliges" {
  account_role_name = snowflake_account_role.engineer_role.name
  all_privileges    = true
  on_account_object {
    object_type = "DATABASE"
    object_name = snowflake_database.sephora_db.name
  }
}

resource "snowflake_grant_account_role" "engineer_user_grant" {
  role_name = snowflake_account_role.engineer_role.name
  user_name = var.snowflake_user
}

resource "snowflake_database" "sephora_db" {
  name = "SEPHORA_ANALYTICS"
}
