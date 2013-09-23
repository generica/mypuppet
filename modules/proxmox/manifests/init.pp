# Proxmox specific things

class proxmox::proxmox1 {

  file { "/etc/apt/sources.list.d/proxmox.list":
    owner   => root,
    group   => root,
    mode    => 644,
    source  => "puppet:///modules/proxmox/proxmox1.list",
  }

}

class proxmox::proxmox2 {

  file { "/etc/apt/sources.list.d/proxmox.list":
    owner   => root,
    group   => root,
    mode    => 644,
    source  => "puppet:///modules/proxmox/proxmox2.list",
  }

}

class proxmox::proxmox3 {

  file { "/etc/apt/sources.list.d/proxmox.list":
    owner   => root,
    group   => root,
    mode    => 644,
    source  => "puppet:///modules/proxmox/proxmox3.list",
  }

}
