class ntp {

  package { ntp:
    ensure => installed
  }
  
  $ntpd = $operatingsystem ? {
    Debian   => "ntp",
    default  => "ntpd"
  }
        
  service { $ntpd:
    ensure  => running,
    enable  => true,
    require => Package["ntp"]
  }

  file { "/etc/ntp.conf":
    owner   => root,
    group   => root,
    mode    => 644,
    require => Package["ntp"],
    source	=> "puppet:///files/misc/ntp.conf",
    notify   => $operatingsystem ? {
      Debian => Service[ntp],
      CentOS => Service[ntpd],
      Fedora => Service[ntpd],
    },
  }

  #nagios::service { "ntp":
  #  check_command => "check_ntp_time"
  #}

}
