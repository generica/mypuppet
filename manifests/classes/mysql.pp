class mysql {

  package { "mysql-server":
    ensure => installed,
  }

  $mysqld = $operatingsystem ? {
    Debian   => "mysql",
    default  => "mysqld"
  }

  service { $mysqld:
    ensure  => running,
    enable  => true,
    require => Package["mysql-server"],
  }
  
}
