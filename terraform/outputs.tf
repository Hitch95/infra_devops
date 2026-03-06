# Outputs - Informations sur l'infrastructure déployée

output "api_url" {
  description = "URL de l'API"
  value       = "http://localhost:${var.api_port}"
}

output "adminer_url" {
  description = "URL d'Adminer (gestion BDD)"
  value       = "http://localhost:${var.adminer_port}"
}

output "network_name" {
  description = "Nom du réseau Docker"
  value       = docker_network.app_network.name
}

output "database_url" {
  description = "URL de connexion à la base de données"
  value       = "postgres://${var.db_user}:${var.db_password}@postgres:5432/${var.db_name}"
  sensitive   = true
}

output "endpoints" {
  description = "Endpoints disponibles"
  value       = {
    api_health = "http://localhost:${var.api_port}/health"
    api_home   = "http://localhost:${var.api_port}/"
    adminer    = "http://localhost:${var.adminer_port}"
  }
}
