variable "aws_region" {
  description = "AWS region for the demo infrastructure."
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Project name used for AWS resource naming."
  type        = string
  default     = "secondchance"
}

variable "backend_container_port" {
  description = "Port exposed by the backend container."
  type        = number
  default     = 3060
}

variable "frontend_container_port" {
  description = "Port exposed by the frontend container"
  type        = number
  default     = 9000
}

variable "backend_image_tag" {
  description = "Docker image tag deployed to ECS for the backend."
  type        = string
  default     = "amd64-v1"
}

variable "frontend_image_tag" {
  description = "Docker image tag deployed to ECS for the frontend."
  type        = string
  default     = "amd64-v1"
}

variable "mongodb_url" {
  description = "MongoDB Atlas connection string used by the backend"
  type        = string
  sensitive   = true
}

variable "jwt_secret" {
  description = "JWT signing secret used by the backend."
  type        = string
  sensitive   = true
}

variable "mongodb_database" {
  description = "MongoDB database name."
  type        = string
  default     = "secondChance"
}

variable "mongodb_collection" {
  description = "MongoDB collection name."
  type        = string
  default     = "secondChanceItems"
}