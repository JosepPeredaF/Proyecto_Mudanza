variable "aws_region" {
  description = "Región de AWS"
  type        = string
  default     = "us-east-2"
}

variable "project" {
  description = "Nombre del proyecto"
  type        = string
}

variable "environment" {
  description = "Entorno de despliegue"
  type        = string
}

variable "vpc_cidr" {
  description = "Rango CIDR de la VPC"
  type        = string
}