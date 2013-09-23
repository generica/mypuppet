class postfix-package {

  package { postfix:
    ensure => installed
  }

  package { ["sendmail-cf","sendmail"]:
    ensure => purged
  }

  package { exim4:
    ensure => purged
  }

  package { exim4-base:
    ensure => purged
  }

  package { exim4-daemon-light:
    ensure => purged
  }

  package { exim4-config:
    ensure => purged
  }

  service { postfix:
    ensure  => running,
    enable  => true,
    require => Package[postfix]
  }
}

