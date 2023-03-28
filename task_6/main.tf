provider "google" {
  project = "central-muse-376718"
  region  = "us-central1"
  zone    = "us-central1-c"
}

resource "google_storage_bucket" "static-site" {
  name          = "task_6"
  location      = "US"

  uniform_bucket_level_access = true

  website {
    main_page_suffix = "index.html"
    not_found_page   = "404.html"
  }
  cors {
    origin          = ["http://image-store.com"]
    method          = ["GET", "HEAD", "PUT", "POST", "DELETE"]
    response_header = ["*"]
    max_age_seconds = 3600
  }
}


resource "google_compute_instance" "task6" {
  name         = "task6"
  machine_type = "e2-medium"
  zone         = "us-central1-a"

  tags = ["dareit"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      labels = {
        managed_by_terraform = "true"
      }
    }
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral public IP
    }
  }
}


resource "google_sql_database_instance" "dareit" {
  name             = "dareit"
  database_version = "POSTGRES_14"
  region           = "us-central1"

  settings {
    tier = "db-f1-micro"
  }
}

resource "google_sql_database_instance" "dareit" {
  name             = "dareit"
  database_version = "POSTGRES_14"
  region           = "us-central1"

  settings {
    tier = "db-f1-micro"
  }
}

resource "google_sql_database" "dareit" {
  name     = "dareit"
  instance = google_sql_database_instance.dareit
}

resource "google_sql_database_instance" "dareit_user" {
  name             = "dareit_user-${random_id.db_name_suffix.hex}"
  database_version = "POSTGRES_14"

  settings {
    tier = "db-f1-micro"
  }
}

resource "google_sql_user" "dareit_user" {
  name     = "dareit_user"
  instance = google_sql_database_instance.dareit
  password = "lalala"
}