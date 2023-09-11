# Create a Cloud SQL instance
resource "google_sql_database_instance" "example" {
  name              = "example-db-instance"
  database_version  = "MYSQL_8_0"
  project           = "imposing-voyage-392509"
  region            = "us-central1"
  settings {
    tier = "db-f1-micro"  # Choose an appropriate tier
  }
}

# Create a SQL user for Cloud Run
resource "google_sql_user" "cloud_run_user" {
  name     = "cloud-run-user"
  instance = google_sql_database_instance.example.name
  password = "Password@321"
}

# Create a database for your application
resource "google_sql_database" "example" {
  name     = "example-database"
  instance = google_sql_database_instance.example.name
}

# Create a Cloud Run service
resource "google_cloud_run_service" "example" {
  name     = "example-cloud-run-service"
  location = "us-central1"

  template {
    spec {
      containers {
        image = "us.gcr.io/imposing-voyage-392509/gcp-cloudbuild/plan-config-app:be745da2e2d2f72b061bd8747053b65254ea44ec"
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}

# Allow Cloud Run service to connect to the SQL instance
resource "google_sql_database_instance_iam_member" "cloud_run_member" {
  instance = google_sql_database_instance.example.name
  role     = "cloudsql.client"
  member   = "serviceAccount:${google_cloud_run_service.example.service_account_email}"
}

# Allow the Cloud Run service to store data in Cloud SQL
resource "google_sql_database_instance_iam_policy" "cloud_run_policy" {
  instance = google_sql_database_instance.example.name

  binding {
    role    = "roles/cloudsql.editor"
    members = ["serviceAccount:${google_cloud_run_service.example.service_account_email}"]
  }
}

# Grant necessary permissions to Cloud Run service account
resource "google_project_iam_member" "cloud_run_iam_member" {
  project = "imposing-voyage-392509"
  role    = "roles/run.invoker"
  member  = "serviceAccount:${google_cloud_run_service.example.service_account_email}"
}
