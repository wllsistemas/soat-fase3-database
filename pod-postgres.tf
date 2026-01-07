resource "kubernetes_deployment_v1" "lab_soat_postgres" {
  metadata {
    name = "lab-soat-postgres"
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "lab-soat-postgres"
      }
    }
    template {
      metadata {
        labels = {
          app = "lab-soat-postgres"
        }
      }
      spec {
        container {
          name              = "lab-soat-postgres"
          image             = "postgres:17.5"
          image_pull_policy = "IfNotPresent"
          port {
            container_port = 5432
          }
          env {
            name  = "PGDATA"
            value = "/var/lib/postgresql/data/pgdata"
          }
          env_from {
            secret_ref {
              name = "lab-soat-secret-postgres"
            }
          }
          volume_mount {
            mount_path = "/var/lib/postgresql/data"
            name       = "postgresdb"
          }
        }
        volume {
          name = "postgresdb"
          persistent_volume_claim {
            claim_name = "lab-postgres-pvc"
          }
        }
      }
    }
  }
}