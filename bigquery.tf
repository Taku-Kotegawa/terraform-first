# ---------------------------------------------------------
# データセット
# ---------------------------------------------------------

resource "google_bigquery_dataset" "dataset" {
  dataset_id                      = "example_dataset"
  friendly_name                   = "test"
  description                     = "This is a test description"
  default_table_expiration_ms     = 5184000000
  default_partition_expiration_ms = 5184000000
  location                        = "asia-northeast1"
}

# ---------------------------------------------------------
# テーブル
# ---------------------------------------------------------
resource "google_bigquery_table" "t_users" {
  dataset_id          = google_bigquery_dataset.dataset.dataset_id
  table_id            = "t_users"
  deletion_protection = false

  schema = file("./schema/t_users.json")

}

# ---------------------------------------------------------
# プロシージャ
# ---------------------------------------------------------


// マート更新

resource "google_bigquery_routine" "read_t_users" {
  dataset_id      = google_bigquery_dataset.dataset.dataset_id
  routine_id      = "read_t_users"
  routine_type    = "PROCEDURE"
  language        = "SQL"
  definition_body = file("./procedure/read_t_users.bq")
}

resource "google_bigquery_routine" "read_t_users2" {
  dataset_id      = google_bigquery_dataset.dataset.dataset_id
  routine_id      = "read_t_users2"
  routine_type    = "PROCEDURE"
  language        = "SQL"
  definition_body = file("./procedure/read_t_users.bq")
}


