# Variables pour l'infrastructure locale

variable "project_name" {
  description = "Nom du projet"
  type        = string
  default     = "infra-devops"
}

variable "app_env" {
  description = "Environnement de l'application"
  type        = string
  default     = "dev"
}

variable "api_port" {
  description = "Port pour l'API Node.js"
  type        = number
  default     = 3003
}

variable "adminer_port" {
  description = "Port pour Adminer (interface BDD)"
  type        = number
  default     = 8080
}

variable "db_user" {
  description = "Utilisateur de la base de données"
  type        = string
  default     = "admin"
}

variable "db_password" {
  description = "Mot de passe de la base de données"
  type        = string
  default     = "admin123"
  sensitive   = true
}

variable "db_name" {
  description = "Nom de la base de données"
  type        = string
  default     = "appdb"
}
