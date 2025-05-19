provider "snowflake" {
  organization_name = var.snowflake_organization_name
  account_name      = var.snowflake_account_name
  user              = var.snowflake_user
  password          = var.snowflake_password
}

# Create Sephora database

module "database" {
  source             = "./modules/terraform-snowflake-database"
  database_name      = local.database_name
  database_role_name = module.role.role_name
}

# Create a Role
module "role" {
  source    = "./modules/terraform-snowflake-role"
  role_name = local.role_name
}

# Create a Warehouse
module "warehouse" {
  source              = "./modules/terraform-snowflake-warehouse"
  warehouse_role_name = module.role.role_name
  warehouse_name      = local.warehouse_name
  warehouse_size      = local.warehouse_size
}

# Grant user to my user
resource "snowflake_grant_account_role" "engineer_user_grant" {
  role_name = module.role.role_name
  user_name = var.snowflake_user
}
