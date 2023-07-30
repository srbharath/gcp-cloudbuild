terraform {
  backend "gcs" {
    bucket = "terraform-sftp-buckect"
    prefix = "sftp-to-bucket/terraform.tfstate"
  }
}



