terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.2"
    }
  }
}

provider "docker" {}

resource "docker_image" "nginx_image" {
  name = "nginx:latest"
  build {
    context    = "./docker_nginx"
    dockerfile = "Dockerfile"
  }
}

resource "docker_container" "nginx_server" {
  name  = var.container_name
  image = docker_image.nginx_image.name
  ports {
    internal = 80
    external = var.external_port
  }
}

resource "docker_container" "redis_server" {
  image = "redis:alpine"
   name  = var.redis_container_name
  ports {
    internal = 6379
    external = var.redis_external_port
  }
}