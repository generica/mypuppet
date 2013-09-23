class bind {

  file { "/etc/named.conf":
    owner   => root,
    group   => root,
    mode    => 644,
    source  => ["puppet:///modules/bind/${fqdn}/named.conf", "puppet:///modules/bind/named.conf"],
  }
  file { "/etc/resolv.conf":
    owner   => root,
    group   => root,
    mode    => 644,
    source  => ["puppet:///modules/bind/${fqdn}/resolv.conf", "puppet:///modules/bind/resolv.conf"],
  }

  package { "bind":
    ensure  => installed,
  }

}

