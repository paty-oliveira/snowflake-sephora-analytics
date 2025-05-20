terraform {
  cloud {

    organization = "paty-training"

    workspaces {
      name = "gh-actions-snowflake-sephora"
    }
  }

  required_providers {
    snowflake = {
      source = "Snowflake-Labs/snowflake"
    }
  }
}
