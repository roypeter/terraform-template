module "order_service" {
  source = "../../../../../modules/java-app"
  app_name = "order_service"
  app_instance_type = "c4.large"
}
