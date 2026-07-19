variable "project_id" {
  type = string
}

variable "region" {
  default = "asia-south1"
}

variable "vpc_name" {
  default = "prod-vpc"
}

variable "web_subnet_name" {
  default = "web-subnet"
}

variable "web_subnet" {
  default = "10.0.1.0/24"
}

variable "machine_type" {
  default = "e2-medium"
}

variable "db_name" {
  default = "employee_db"
}

variable "db_user" {
  default = "appuser"
}

variable "db_password" {
  type      = string
  sensitive = true
}