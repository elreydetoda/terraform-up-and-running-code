provider "aws" {
  region = "us-east-2"
} 

terraform {
    backend "s3" {
        bucket  = "elrey741-terraform-up-and-running-state"
        key     = "stage/data-stores/mysql/terraform.tfstate"
        region  = "us-east-2"

        dynamodb_table  = "terraform-up-and-running-locks"
        encrypt             = true
    }
}

resource "aws_db_instance" "example-db" {
    identifier_prefix = "terraform-up-and-running"
    engine            = "mysql"
    allocated_storage = 10
    instance_class    = "db.t2.micro"
    name              = "example_database"
    username          = "admin"

    password          = var.db_password

    # added to delete database
    #skip_final_snapshot = true
    
}
