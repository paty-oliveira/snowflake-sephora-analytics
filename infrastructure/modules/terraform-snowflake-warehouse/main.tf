resource "snowflake_warehouse" "this" {
  name           = var.warehouse_name
  warehouse_size = var.warehouse_size
}

resource "snowflake_grant_privileges_to_account_role" "warehouse_privileges" {
  account_role_name = var.warehouse_role_name
  all_privileges    = true
  on_account_object {
    object_type = "WAREHOUSE"
    object_name = snowflake_warehouse.this.name
  }
}
