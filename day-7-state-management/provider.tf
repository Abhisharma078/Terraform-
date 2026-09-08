provider "aws" {
    region = "ap-south-1"
    profile = "abhi"
}

terraform {
  backend "s3" {
    region = "ap-south-1"
    profile = "abhi"
    shared_credentails_files = ["/root/.aws/credentails"]
    key = "terraform.tfstate"
    use_lockfile = true
  }
}
