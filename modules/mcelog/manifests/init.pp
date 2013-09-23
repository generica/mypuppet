class mcelog {

  package { mcelog:
    ensure => installed
  }

  $nrpe_package = $operatingsystem ? {
    Debian   => "nagios-nrpe-server",
    CentOS   => "nrpe",
    RedHat       => "nrpe",
  }

  file { "/etc/nagios/conf.d/nrpe_check_mcelog.cfg":
    owner   => root,
    group   => root,
    mode    => 644,
    source  => "puppet:///modules/mcelog/nrpe_check_mcelog.cfg",
    notify  => Service[$nrpe_package],
  }

  file { "/usr/local/lib/nagios/plugins/check_mcelog":
    owner   => root,
    group   => root,
    mode    => 755,
    source  => "puppet:///modules/mcelog/check_mcelog",
  }


}
