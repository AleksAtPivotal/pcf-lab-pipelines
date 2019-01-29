module "pks-azure" {
    source = "github.com/pivotal-cf/terraforming-azure/terraforming-pks"
    version = "v0.29.0"
    env_name = "${var.pks_env_name}"
    env_short_name = "${var.pks_env_shortname}"
    ops_manager_image_uri = "${var.ops_manager_image_uri}"
    location = "${var.AZURE_REGION}"
}

variable "pks_env_name" {
    type = "string"
}

variable "pks_env_shortname" {
    type = "string"
}
variable "ops_manager_image_uri" {
    type = "string"
}