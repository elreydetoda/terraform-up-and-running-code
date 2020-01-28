output "address" {
  value         = aws_db_instance.example-db.address
  description   = "Connect to the database at this endpoint"
}

output "port" {
  value         = aws_db_instance.example-db.port
  description   = "the port for the db"
}
