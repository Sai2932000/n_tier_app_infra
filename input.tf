
variable "region" {
  type    = string
  default = "asia-south1"

}

variable "subnet_range" {
  type    = list(string)
  default = ["192.168.0.0/24", "192.168.1.0/24", "192.168.2.0/24"]
}

variable "names" {
  type    = list(string)
  default = ["web", "app", "db"]
}


  