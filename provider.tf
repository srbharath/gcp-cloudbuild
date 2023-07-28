terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.73.0"
    }
  }
  # Enable logging and specify the log file location
  
}

provider "google" {
  # Configuration options
  project = "imposing-voyage-392509"
  zone = "us-central1-a"
  # credentials = "keys.json"  #create a service account, Assign required permission for SA and download the key 
}

