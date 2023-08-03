
variable "project_name" {
   type        = string
   description = "project name or id" 
   default = "imposing-voyage-392509"
}
variable "region" {
  type        = string
  description = "gcp region"
  default = "us-central1"
}

variable "vpc_name" {
    type = string
    description = "vpc_name"
    default = "sftp-prod"
}
variable "subnetwork_name" {
	type = string
    description = "name of the subnet"
    default = "external-sftp"
}
variable "ip_cidr_range" {
	type = string
    description = "subnet cidr block"
    default = "10.123.0.0/28"
}

variable "vpc_access_connector" {
	type = string
    description = "vpc_access_connector name"
    default = "external-sftp-static-ip"

}
variable "router_name" {
	type = string
    description = "google_router_name"
    default = "sftp-router"
}
variable "google_compute_address" {
    type = string
    description = "static ip name"
    default = "sftp-static-ip"
}
variable "Cloud_Nat" {
    type = string
    description = "cloud Nat name"
    default = "sftp-cloud-nat"
}
variable "Cloud_Run_job" {
    type = string
    description = "cloud Nat name"
    default = "sftp-to-buckect-job"
}
variable "Cloud_Run_image" {
    type = string
    description = "cloud Nat name"
    default = "us-docker.pkg.dev/cloudrun/container/hello"
}
variable "Gcs_buckect_name" {
    type = string
    description = "google storage buckect"
    default = "terraform-sftp-buckect"
}