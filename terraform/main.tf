# Configuration du provider Docker local
provider "docker" {
  host = "npipe:////./pipe/docker_engine"
}

# ============================================
# RÉSEAU Docker
# ============================================
resource "docker_network" "app_network" {
  name   = "${var.project_name}-network"
  driver = "bridge"
}

# ============================================
# BASE DE DONNÉES PostgreSQL
# ============================================
resource "docker_image" "postgres" {
  name         = "postgres:16-alpine"
  keep_locally = true
}

resource "docker_container" "postgres" {
  name  = "postgres"
  image = docker_image.postgres.image_id

  networks_advanced {
    name = docker_network.app_network.name
  }

  env = [
    "POSTGRES_USER=${var.db_user}",
    "POSTGRES_PASSWORD=${var.db_password}",
    "POSTGRES_DB=${var.db_name}"
  ]

  ports {
    internal = 5432
    external = 5432
  }

  volumes {
    volume_name    = docker_volume.postgres_data.name
    container_path = "/var/lib/postgresql/data"
  }

  must_run = true
  restart  = "unless-stopped"
}

resource "docker_volume" "postgres_data" {
  name = "infra-devops-pgdata"
}

# ============================================
# ADMINER - Interface graphique BDD (optionnel)
# ============================================
resource "docker_image" "adminer" {
  name         = "adminer:latest"
  keep_locally = true
}

resource "docker_container" "adminer" {
  name  = "${var.project_name}-adminer"
  image = docker_image.adminer.image_id

  networks_advanced {
    name = docker_network.app_network.name
  }

  ports {
    internal = 8080
    external = var.adminer_port
  }

  depends_on = [docker_container.postgres]

  must_run = true
  restart  = "unless-stopped"
}

# ============================================
# APPLICATION Node.js
# ============================================
resource "docker_image" "app" {
  name         = "${var.project_name}-api:latest"
  build {
    context    = "../app"
    dockerfile = "Dockerfile"
  }
  keep_locally = true
}

resource "docker_container" "api" {
  name  = "${var.project_name}-api"
  image = docker_image.app.image_id

  networks_advanced {
    name = docker_network.app_network.name
  }

  ports {
    internal = 3000
    external = var.api_port
  }

  env = [
    "PORT=3000",
    "APP_ENV=${var.app_env}",
    "DATABASE_URL=postgres://${var.db_user}:${var.db_password}@postgres:5432/${var.db_name}"
  ]

  depends_on = [docker_container.postgres]

  must_run = true
  restart  = "unless-stopped"
}
