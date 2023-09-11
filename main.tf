# Create a Cloud SQL instance
resource "google_sql_database_instance" "example" {
  name             = "example-instance"
  database_version = "MYSQL_5_7"
  region           = "us-central1" # Adjust the region as needed

  settings {
    tier = "db-f1-micro" # Adjust the tier as needed
  }
}

# Create a database in the Cloud SQL instance
resource "google_sql_database" "example" {
  name     = "example-database"
  instance = google_sql_database_instance.example.name
}

# Create a Cloud Run service
resource "google_cloud_run_service" "example" {
  name     = "example-service"
  location = "us-central1" # Adjust the location as needed

  template {
    spec {
      containers {
        image = "us.gcr.io/imposing-voyage-392509/gcp-cloudbuild/plan-config-app:be745da2e2d2f72b061bd8747053b65254ea44ec"
      }
    }
  }
}

# Configure Cloud Run to use Cloud SQL
resource "google_cloud_run_service_iam_policy" "example" {
  service = google_cloud_run_service.example.name

  policy_data = <<EOF
{
  "bindings": [
    {
      "members": [
        "serviceAccount:${google_cloud_run_service.example.iam_identity.0.email}"
      ],
      "role": "roles/cloudsql.client"
    }
  ]
}
EOF
}

# Output the URL of the Cloud Run service
output "service_url" {
  value = google_cloud_run_service.example.status[0].url
}
