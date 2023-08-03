
#Create the VPC network 
resource "google_compute_network" "default" {
  name     = var.vpc_name
}
#Create a subnetwork in the VPC for the Serverless VPC Access connector
resource "google_compute_subnetwork" "default" {
  name          = var.subnetwork_name
  ip_cidr_range = var.ip_cidr_range
  network       = google_compute_network.default.id
  region        = var.region
}
#To create a Serverless VPC Access connector
resource "google_project_service" "vpc" {
  service            = "vpcaccess.googleapis.com"
  disable_on_destroy = false
}
resource "google_vpc_access_connector" "default" {
  name     = var.vpc_access_connector
  region   = var.region

  subnet {
    name = google_compute_subnetwork.default.name
  }

  # Wait for VPC API enablement
  # before creating this resource
  depends_on = [
    google_project_service.vpc
  ]
}
#Create a new Cloud Router to program a NAT gateway
resource "google_compute_router" "default" {
  name     = var.router_name
  network  = google_compute_network.default.name
  region   = google_compute_subnetwork.default.region
}
#Reserve a static IP address.
resource "google_compute_address" "default" {
  name     = var.google_compute_address
  region   = google_compute_subnetwork.default.region
}
#Create a Cloud NAT gateway configuration on this router to route the traffic originating from the VPC network using the static IP address you created
resource "google_compute_router_nat" "default" {
  name     = var.Cloud_Nat
  router   = google_compute_router.default.name
  region   = google_compute_subnetwork.default.region

  nat_ip_allocate_option = "MANUAL_ONLY"
  nat_ips                = [google_compute_address.default.self_link]

  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
  subnetwork {
    name                    = google_compute_subnetwork.default.id
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }
}
#This Cloud Run service uses a VPC connector and routes all egress traffic through it
resource "google_cloud_run_v2_job" "default" {
  name     = var.Cloud_Run_job
  location = "us-central1"

  template {
    template {
      containers {
        image = var.Cloud_Run_image
      }
  vpc_access {
    connector = google_vpc_access_connector.default.id
      egress    = "ALL_TRAFFIC"
    }
    }
  }
}

# Create the service account
# resource "google_service_account" "sa" {
#   account_id   = "<SA_NAME>"  # Replace with your desired service account name
#   display_name = "<SA_NAME>"  # Replace with your desired display name for the service account
# }

# # Add IAM policy binding to the project
# resource "google_project_iam_member" "sa_object_admin" {
#   project = var.project_name
#   role    = "roles/storage.objectAdmin"
#   member  = "serviceAccount:${google_service_account.sa.email}"
# }

# # Add IAM policy binding to the secret
# resource "google_secret_manager_secret_iam_member" "sa_secret_accessor" {
#   secret_id = "<SFTP_CREDENTIALS_SECRET_NAME>"  # Replace with the name of your secret
#   role      = "roles/secretmanager.secretAccessor"
#   member    = "serviceAccount:${google_service_account.sa.email}"
# }

terraform {
  backend "gcs" {
    bucket = "terraform-sftp-buckect"
    prefix = "sftp-to-bucket/terraform.tfstate"
  }
}

resource "google_cloud_run_v2_job" "default1" {
  name     = "Cloud_Run_job"
  location = "us-central1"

  template {
    template {
      containers {
        image = var.Cloud_Run_image
      }
  vpc_access {
    connector = google_vpc_access_connector.default.id
      egress    = "ALL_TRAFFIC"
    }
    }
  }
}
