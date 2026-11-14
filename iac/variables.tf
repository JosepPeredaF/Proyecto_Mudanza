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

variable "availability_zones" {
  description = "Zonas de disponibilidad donde se crean las subredes"
  type        = list(string)
}

variable "private_app_subnet_cidrs" {
  description = "Rangos de las subredes privadas de aplicación"
  type        = list(string)
}

variable "private_data_subnet_cidrs" {
  description = "Rangos de las subredes privadas de datos"
  type        = list(string)
}

variable "public_subnet_cidrs" {
  description = "Rangos de las subredes públicas"
  type        = list(string)
}

variable "frontend_bucket_name" {
  description = "Nombre del bucket S3 del frontend"
  type        = string
}