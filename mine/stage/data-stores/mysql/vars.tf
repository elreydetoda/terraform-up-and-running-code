variable "db_password" {
    description = "password for db"
    type        = string
    # I know this is bad practice I won't do this in production. I will use Vault secret store
    default     = "password"
}
