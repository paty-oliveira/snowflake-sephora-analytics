provider "snowflake" {
    organization_name =  var.organization_name
    account_name = var.account_name
    user = var.username
    authenticator = "SNOWFLAKE_JWT"
    private_key = file(var.private_key_path)
}
