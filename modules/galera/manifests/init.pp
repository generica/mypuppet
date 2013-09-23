class galera {

  file { "/etc/mysql/debian.cnf":
    owner   => root,
    group   => root,
    mode    => 644,
    source  => "puppet:///modules/galera/debian.cnf",
  }

  file { "/etc/mysql/conf.d/vlsci.cnf":
    owner   => root,
    group   => root,
    mode    => 644,
    source  => ["puppet:///modules/galera/${fqdn}/vlsci.cnf", "puppet:///modules/galera/vlsci.cnf"],
  }

  file { "/etc/init.d/glb":
    owner   => root,
    group   => root,
    mode    => 755,
    source  => "puppet:///modules/galera/glb-init",
  }

  file { "/etc/nagios/conf.d/nrpe_check_galera.cfg":
    owner   => root,
    group   => root,
    mode    => 644,
    source  => "puppet:///modules/galera/nrpe_check_galera.cfg",
    notify  => Service[nagios-nrpe-server],
  }

  file { "/usr/local/lib/nagios/plugins/check_galera_status":
    owner   => root,
    group   => root,
    mode    => 755,
    source  => "puppet:///modules/galera/check_galera_status",
  }

  file { "/usr/local/sbin/is_glb_master":
    owner   => root,
    group   => root,
    mode    => 755,
    source  => "puppet:///modules/galera/is_glb_master",
  }

  package { "rsync":
    ensure  => installed,
  }

  package { "python-mysqldb":
    ensure  => installed,
  }

}

