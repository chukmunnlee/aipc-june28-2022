variable DO_token {
    type = string 
    sensitive = true
}

variable mynet {
    type = string
    default = "mynet"
} 

variable DB_user {
    type = string
    default = "root"
}
variable DB_password {
    type = string
    sensitive = true
}

variable nwdb_tag {
    type = string
    default = "v1"
}
variable nwapp_tag {
    type = string
    default = "v1"
}
