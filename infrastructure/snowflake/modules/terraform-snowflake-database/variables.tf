variable "database_name" {
  description = "Database name."
  type        = string
}

variable "database_role_name" {
  description = "Database role."
  type        = string
}

variable "database_schemas" {
  description = "List of schemas."
  type        = set(string)
}
