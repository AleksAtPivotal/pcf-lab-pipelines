module "pks-aws" {
    source = "github.com/pivotal-cf/terraforming-aws/terraforming-pks"
    version = "v0.22.0"
    access_key = ""
    secret_key = ""
    region = ""
    availability_zones = ""
    env_name = ""
    dns_suffix = ""
}

variable "access_key" {
   type = "string"
}

variable "secret_key" {
   type = "string"
}

variable "region" {
   type = "string"
}

variable "availability_zones" {
   type = "string"
}

variable "env_name" {
   type = "string"
}

variable "dns_suffix" {
   type = "string"
}


