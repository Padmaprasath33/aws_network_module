variable "region" {
  description = "AWS region"
  //default     = "us-east-1"
}

variable "account_id" {
  description = "AWS account ID"
  //default     = "us-east-1"
}

variable "resource_tags" {
  description = "Tags to set for all resources"
  type        = map(string)
  /*default     = {
    project     = "aws-proserv",
    environment = "dev"
    application = "cohort-demo"
  }
  */
}

variable "resource_tags_dr" {
  description = "Tags to set for all resources"
  type        = map(string)
  /*default     = {
    project     = "aws-proserv",
    environment = "dev"
    application = "cohort-demo"
    backup      = "yes"
  }
  */
}

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

variable "elb_sg_ingress_ports" {
  type    = list(number)
  default = [80, 443, 8080]
}

/*variable "vpc_main_flowlog_role_name" {
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
*/