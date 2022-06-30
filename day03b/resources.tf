data digitalocean_ssh_key chuk {
  name = "chuk"
}

resource digitalocean_droplet nginx {
  name = "nginx"
  image = var.DO_image
  size = var.DO_size
  region = var.DO_region
  ssh_keys = [ data.digitalocean_ssh_key.chuk.id ]
}

resource local_file root_at_nginx {
  content = ""
  filename = "root@${digitalocean_droplet.nginx.ipv4_address}"
}

output nginx_ip {
  value = digitalocean_droplet.nginx.ipv4_address
}
