variable "snowflake_organization_name" {
  type        = string
  description = "Snowflake organization name."
  sensitive   = true
}

variable "snowflake_account_name" {
  type        = string
  description = "Snowflake account name."
  sensitive   = true
}

variable "snowflake_user" {
  type        = string
  description = "Snowflake user name."
  sensitive   = true
}

variable "snowflake_password" {
  type        = string
  description = "Snowflake password."
  sensitive   = true
}

variable "snowflake_region" {
  type        = string
  description = "Snowflake account region."

}
