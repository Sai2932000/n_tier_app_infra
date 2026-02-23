
variable "region" {
  type    = string
  default = "asia-south1"

}

variable "app_ip_cidr_range" {
  type    = string
  default = "10.100.2.0/24"
}

variable "web_ip_cidr_range" {
  type    = string
  default = "10.100.1.0/24"
}
variable "db_ip_cidr_range" {
  type    = string
  default = "10.100.3.0/24"
}

variable "app_subnet_name" {
  type    = string
  default = "app1"

}

variable "web_subnet_name" {
  type    = string
  default = "web1"

}

variable "db_subnet_name" {
  type    = string
  default = "db1"

}
