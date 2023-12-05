variable "az_count" {
  description = "Number of AZs to cover in a given region"
  //default     = ""
}

variable "cidr_block" {
  description = "VPC Cidr range"
  //default     = ""
}

variable "app_port" {
  description = "Port exposed by the docker image to redirect traffic to"
  //default     = 80
}

variable "vpc_main_flowlog_role_name" {
  description = "VPC main flowlog role name"
  //default     = ""
}

variable "vpc_main_flowlog_policy_name" {
  description = "VPC main flowlog policy name"
  //default     = ""
}

variable "vpc_main_flowlog_group_name" {
  description = "VPC main flowlog group name"
  //default     = ""
}

variable "s3_endpoint_service_name" {
  description = "s3_endpoint_service_name"
  //default = ""
}

variable "dynamodb_endpoint_service_name" {
  description = "dynamodb_endpoint_service_name"
  //default = ""
}

variable "ecr_dkr_endpoint_service_name" {
  description = "ecr_dkr_endpoint_service_name"
  //default = ""
}

variable "ecr_api_endpoint_service_name" {
  description = "ecr_api_endpoint_service_name"
  //default = ""
}

variable "ecr_logs_endpoint_service_name" {
  description = "ecr_logs_endpoint_service_name"
  //default = ""
}

variable "alb_sg_name" {
  description = "alb_sg_name"
  //default = ""
}

variable "ecs_tasks_sg_name" {
  description = "ecs_tasks_sg_name"
  //default = ""
}

variable "ecr_endpoint_vpce_sg_name" {
  description = "ecr_endpoint_vpce_sg_name"
  //default = ""
}