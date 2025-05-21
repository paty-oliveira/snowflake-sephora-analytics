resource "snowflake_database" "this" {
  name = var.database_name
}

resource "snowflake_schema" "schemas" {
  for_each = var.database_schemas

  name     = each.value
  database = snowflake_database.this.name
}


resource "snowflake_grant_privileges_to_account_role" "grant_all_privileges_on_database" {
  account_role_name = var.database_role_name
  all_privileges    = true
  on_account_object {
    object_type = "DATABASE"
    object_name = snowflake_database.this.name
  }
}

resource "snowflake_grant_privileges_to_account_role" "grant_all_privileges_on_all_schemas" {
  account_role_name = var.database_role_name
  all_privileges    = true
  on_schema {
    all_schemas_in_database = snowflake_database.this.name
  }
}

resource "snowflake_grant_privileges_to_account_role" "grant_select_on_all_tables" {
  account_role_name = var.database_role_name
  privileges        = ["SELECT", "INSERT"]
  on_schema_object {
    all {
      object_type_plural = "TABLES"
      in_database        = snowflake_database.this.name
    }
  }
}

resource "snowflake_grant_privileges_to_account_role" "grant_select_on_all_views" {
  account_role_name = var.database_role_name
  privileges        = ["SELECT", "INSERT"]
  on_schema_object {
    all {
      object_type_plural = "VIEWS"
      in_database        = snowflake_database.this.name
    }
  }
}
