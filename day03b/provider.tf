terraform {
  required_version = "> 1.2"
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "2.21.0"
    }
    local = {
      source = "hashicorp/local"
      version = "2.2.3"
    }
  }
}

provider digitalocean {
  token = var.DO_token
}

provider local { }
