provider "aws" {
    region = "ap-south-1"
    profile = "abhi"
}

terraform {
  backend "s3" {
    region = "ap-south-1"
    profile = "abhi"
    shared_credentials_files = ["/root/.aws/credentials"]
    key = "terraform.tfstate"
    use_lockfile = true
  }
}
