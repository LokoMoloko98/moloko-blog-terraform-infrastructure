# module "networking" {
#   source                 = "./networking"
#   region                 = var.region
#   public_subnet_az1_cidr = var.public_subnet_az1_cidr
#   vpc_cidr               = var.vpc_cidr
#   project_name           = var.project_name
# }

module "database" {
  source = "./database"
  project_name = var.project_name
  region       = var.region
}

module "iam" {
  source       = "./iam"
  project_name = var.project_name
  region       = var.region
  dynamodb-arn = module.database.moloko-blog-dynamodb-table-arn
}

module "compute" {
  source            = "./compute"
  # security_group_id = module.networking.security_group_id
  # subnet_id         = module.networking.subnet_id
  region            = var.region
  project_name      = var.project_name

}