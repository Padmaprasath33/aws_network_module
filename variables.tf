variable "az_count" {
  description = "Number of AZs to cover in a given region"
  //default     = "2"
}

variable "cidr_block" {
  description = "VPC Cidr range"
  //default     = "10.1.0.0/16"
}

variable "app_port" {
  description = "Port exposed by the docker image to redirect traffic to"
  //default     = 80
}

variable "vpc_main_flowlog_role_name" {
  description = "VPC main flowlog role name"
  //default     = "10.1.0.0/16"
}

variable "s3_enpoint_service_name" {
  description = "s3_enpoint_service_name"
  //default = ""
}

variable "dynamodb_enpoint_service_name" {
  description = "dynamodb_enpoint_service_name"
  //default = ""
}