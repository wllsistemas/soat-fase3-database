resource "kubernetes_secret_v1" "lab_secret_postgres" {
  metadata {
    name = "lab-soat-secret-postgres"
  }
  type = "Opaque"
  data = {
    POSTGRES_USER = "postgres" 
    POSTGRES_PASSWORD = "postgres"     
    POSTGRES_DB = "postgres"     
  }
}