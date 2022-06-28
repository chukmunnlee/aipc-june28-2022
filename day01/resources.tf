data digitalocean_ssh_key chuk {
    name = "chuk"
}

resource local_file chuk_public_key {
    filename = "chuk.pub"
    content = data.digitalocean_ssh_key.chuk.public_key
    file_permission = "0644"
}

output chuk_ssh_key_fingerprint {
    value = data.digitalocean_ssh_key.chuk.fingerprint
}
output chuk_ssh_key_id {
    value = data.digitalocean_ssh_key.chuk.id
}

/* ------------- */
data docker_image dov-bear {
    name = "chukmunnlee/dov-bear:v2"
}

resource docker_container dov-bear-container {
    count = length(var.ports)
    name = "dov-bear-${count.index}"
    image = data.docker_image.dov-bear.id
    env = [
        "INSTANCE_NAME=myapp-${count.index}",
        "INSTANCE_HASH=${count.index}"
    ]
    ports {
        internal = 3000
        external = var.ports[count.index]
    }
}

resource docker_container dov-bear-unique {
    for_each = var.containers
    name = each.key
    image = data.docker_image.dov-bear.id
    env = [
        "INSTANCE_NAME=${each.key}"
    ]
    ports {
        internal = 3000
        external = each.value.external_port
    }
}

resource local_file container-name {
    content = join(", ", [ for c in docker_container.dov-bear-container: c.name ])
    filename = "container-names.txt"
    file_permission = "0644"
}

output dov-bar-md5 {
    value = data.docker_image.dov-bear.repo_digest
    description = "SHA of the image"
}

output container-names {
    value = [ for c in docker_container.dov-bear-container: c.name ]
}