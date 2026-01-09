resource "kubernetes_persistent_volume_claim_v1" "lab_postgres_pvc" {
  metadata {
    name = "lab-postgres-pvc"
  }

  spec {
    storage_class_name = kubernetes_storage_class_v1.gp3.metadata[0].name
    access_modes       = ["ReadWriteOnce"]

    resources {
      requests = {
        storage = "1Gi"
      }
    }
  }
}