locals {
  database_name    = "SEPHORA_ANALYTICS"
  role_name        = "ROLE_ENGINEER"
  warehouse_name   = "WAREHOUSE_ENGINEER_S"
  warehouse_size   = "small"
  database_schemas = toset(["RAW", "STAGING", "MARTS"])
}
