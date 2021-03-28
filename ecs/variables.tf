variable "container_name" {
  type        = string
  description = "Container Name"

}

variable "cpu" {
  type        = number
  description = "Fargate instance CPU units to provision (1 vCPU = 1024 CPU units)"
  default     = "256"

}

variable "memory" {
  description = "Fargate instance memory to provision (in MiB)"
  default     = "256"
}


variable "app_port" {
  description = "Port exposed by the docker image to redirect traffic to"
  default     = 80
}

variable "region" {
  description = "AWS Region"
  default     = "ap-southeast-2"
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.16.0/22"
}

variable "private_subnet" {
  type    = string
  default = "10.0.16.0/24"
}

variable "public_subnet" {
  type    = string
  default = "10.0.17.0/24"
}

variable "app_image" {
  default = "http://861838963348.dkr.ecr.ap-southeast-2.amazonaws.com/weather-react:19dc7f9"
}