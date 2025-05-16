provider "snowflake" {
  organization_name = var.organization_name
  account_name      = var.account_name
  user              = var.username
  authenticator     = "SNOWFLAKE_JWT"
  private_key       = file(var.private_key_path)
}

resource "snowflake_account_role" "engineer_role" {
  name = "ROLE_ENGINEER"
}

resource "snowflake_database" "sephora_db" {
  name = "SEPHORA_ANALYTICS"
}
