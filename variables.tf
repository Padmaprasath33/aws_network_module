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