class icinga {

  $icinga_user = $operatingsystem ? {
    Debian   => "icinga",
    CentOS   => "icinga",
    RedHat   => "icinga",
    default  => "icinga",
  }

  $icinga_package = $operatingsystem ? {
    Debian   => "icinga",
    CentOS   => "icinga",
    RedHat	 => "icinga",
  }

  package { $icinga_package:
    ensure => installed,
  }     

  service { "icinga":
    ensure     => running,
    enable     => true,
    hasrestart => false,
    require    => Package[$icinga_package],
  }

  file { "/etc/icinga/conf.d/contacts.cfg":
    owner   => root,
    group   => root,
    mode    => 644,
    source  => "puppet:///modules/icinga/contacts.cfg",
    notify  => Service[icinga],
  }

}
