provider "snowflake" {
  organization_name = var.organization_name
  account_name      = var.account_name
  user              = var.username
  password          = var.password
}

resource "snowflake_account_role" "engineer_role" {
  name = "ROLE_ENGINEER"
}

resource "snowflake_database" "sephora_db" {
  name = "SEPHORA_ANALYTICS"
}
