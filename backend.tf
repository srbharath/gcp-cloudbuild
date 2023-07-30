terraform {
  backend "gcs" {
    bucket = "imposing-voyage-392509-tfstate"
    prefix = "sftp-to-bucket/terraform.tfstate"
  }
}



