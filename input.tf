variable "region" {
  type = string
  default = "asia-south1"
}


variable "web_subnet" {
  type = string
  default = "10.0.1.0/24"
  
}

variable "web_subnet_name" {
  
  type = string
  default = "web-subnet"
  
}



variable "vpc_name" {
  
  type = string
  default = "prod-vpc"
  
}
