class logwatch {

  package { "logwatch":
    ensure => installed,
  }

  case $operatingsystem {
    Debian: { include logwatch::debian }
    CentOS: { include logwatch::centos }
    default: { err("No such operatingsystem: $operatingsystem not defined") }
  }
}

class logwatch::debian {
  
  file { "/etc/logwatch/scripts/services/apt-updates":
    owner   => root,
    group   => root,
    mode    => 750,
    source  => ["puppet:///modules/logwatch/debian/logwatch-apt-updates"],
    require => Package["logwatch"],
  }
  
  file { "/etc/logwatch/conf/services/apt-updates.conf":
    owner   => root,
    group   => root,
    mode    => 644,
    source  => ["puppet:///modules/logwatch/debian/logwatch-apt-updates.conf"],
    require => Package["logwatch"],
  }

  include logwatch::cron
  include logwatch::sysinfo

  case $lsbdistcodename {
	hardy:   { package { "mailx": ensure => installed, } }
	etch:    { package { "mailx": ensure => installed, } }
	lenny:   { package { "bsd-mailx": ensure => installed, } }
	squeeze: { package { "bsd-mailx": ensure => installed, } }
  }
}

class logwatch::centos {

  package { "mailx":
    ensure => installed,
  }
  
  file {"/etc/logwatch/scripts/services" :
    ensure => directory,
    require => Package["logwatch"],
  }
  
  file { "/etc/logwatch/scripts/services/yum-updates":
    owner   => root,
    group   => root,
    mode    => 750,
    source  => ["puppet:///modules/logwatch/centos/logwatch-yum-updates"],
    require => Package["logwatch"],
  }
  
  file { "/etc/logwatch/conf/services/yum-updates.conf":
    owner   => root,
    group   => root,
    mode    => 644,
    source  => ["puppet:///modules/logwatch/centos/logwatch-yum-updates.conf"],
    require => Package["logwatch"],
  }

  include logwatch::cron
  include logwatch::sysinfo
}

class logwatch::sysinfo {

  file { "/etc/logwatch/scripts/services/00-sysinfo":
    owner   => root,
    group   => root,
    mode    => 750,
    source  => ["puppet:///modules/logwatch/misc/logwatch-sysinfo"],
    require => Package["logwatch"],
  }

  file { "/etc/logwatch/conf/services/00-sysinfo.conf":
    owner   => root,
    group   => root,
    mode    => 644,
    source  => ["puppet:///modules/logwatch/misc/logwatch-sysinfo.conf"],
    require => Package["logwatch"],
  }

}

class logwatch::cron {

  cron { "logwatch":
    ensure  => present,
    command => "/bin/sleep $((RANDOM\\%2000)); PATH=/bin:/sbin:/usr/bin:/usr/sbin /usr/sbin/logwatch --archives --mailto root",
    user    => 'root',
    minute  => '30',
	hour	=> '06',
  }

  file { "/etc/cron.daily/00logwatch":
	ensure	=> absent,
  }

  file { "/etc/cron.daily/0logwatch":
	ensure => absent,
  }
}
