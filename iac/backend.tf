terraform {
  backend "s3" {
    bucket       = "mudanza-tfstate-data-x7k2"
    key          = "dev/terraform.tfstate"
    region       = "us-east-2"
    encrypt      = true
    use_lockfile = true
  }
}