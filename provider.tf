terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.73.0"
    }
  }
}

provider "google" {
  # Configuration options
  project = "<PROJECT_NAME>"
  zone = "us-central1-a"
  # credentials = "keys.json"  #create a service account, Assign required permission for SA and download the key 
}

