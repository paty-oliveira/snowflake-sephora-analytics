variable "organization_name" {
  type        = string
  description = "Snowflake organization name."
}

variable "account_name" {
  type        = string
  description = "Snowflake account name."
}

variable "username" {
  type        = string
  description = "Snowflake user name."
  sensitive   = true
}

variable "password" {
  type        = string
  description = "Snowflake password."
  sensitive   = true
}
