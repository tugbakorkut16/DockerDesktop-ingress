resource "kubernetes_ingress" "main_ingress" {
  metadata {
    name = "main-ingress"
    annotations = {
      "nginx.ingress.kubernetes.io/rewrite-target" = "/"
    }
  }

  spec {
    ingress_class_name = "nginx"

    rule {
      http {
        path {
          path = "/api"
          path_type = "Prefix"
          backend {
            service {
              name = kubernetes_service.test-web-service.metadata[0].name
              port {
                number = 80
              }
            }
          }
        }

        path {
          path = "/"
          path_type = "Prefix"
          backend {
            service {
              name = kubernetes_service.test-web-service.metadata[0].name # Bu frontend servisin adıyla değiştirin
              port {
                number = 80
              }
            }
          }
        }
      }
    }
  }
}