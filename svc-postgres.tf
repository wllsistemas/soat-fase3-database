resource "kubernetes_service_v1" "svc_postgres" {
  metadata {
    name = "postgres"
  }

  spec {
    type = "ClusterIP"
    selector = {
      app = "lab-soat-postgres"
    }
    port {
      port        = 5432 
      target_port = 5432 
    }
  }
}