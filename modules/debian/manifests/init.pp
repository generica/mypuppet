# Debian specific things

class debian {

  case $lsbdistcodename {
    etch: { include debian::etch }
    lenny: { include debian::lenny }
    squeeze: { include debian::squeeze }
    wheezy: { include debian::wheezy }
  }

  cron { apt-update:
    ensure => present,
    command => "/usr/bin/apt-get -qq update",
    user => root,
    weekday => 0,
    hour    => 14,
    #minute  => 0;
        minute => fqdn_rand(60)
  }

  cron { apt-clean:
    ensure => present,
    command => "/usr/bin/apt-get -qq autoclean",
    user => root,
    weekday => 0,
    hour    => 15,
    #minute  => 0;
        minute => fqdn_rand(60)
  }

  package { "lsb-release":
    ensure => installed,
    alias  => "lsbrelease"
  }

  package { "tree":
    ensure  => installed,
  }

  package { "bc":
    ensure  => installed,
  }

  package { "psmisc":
    ensure  => installed,
  }

  package { "htop":
    ensure  => installed,
  }

  package { "screen":
    ensure  => installed,
  }

  package { "debian-goodies":
	ensure => installed,
  }

  package { "logwatch":
	ensure => installed,
  }

}

class debian::wheezy-updates {

  file { "/etc/apt/sources.list.d/wheezy-updates.list":
    owner   => root,
    group   => root,
    mode    => 644,
    source  => "puppet:///modules/debian/wheezy-updates.list",
  }

}

class debian::wheezy {

  file { "/etc/apt/sources.list":
    owner   => root,
    group   => root,
    mode    => 644,
    source  => "puppet:///modules/debian/wheezy.list",
  }

  file { "/etc/apt/preferences.d/puppet":
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => 644,
    source  => "puppet:///modules/debian/wheezy-puppet-preferences",
  }

#  file { "/etc/apt/sources.list.d/wheezy-backports.list":
#    owner   => root,
#    group   => root,
#    mode    => 644,
#    source  => "puppet:///modules/debian/wheezy-backports.list",
#  }

}

class debian::squeeze-updates {

  file { "/etc/apt/sources.list.d/squeeze-updates.list":
    owner   => root,
    group   => root,
    mode    => 644,
    source  => "puppet:///modules/debian/squeeze-updates.list",
  }

}

class debian::squeeze {

  file { "/etc/apt/sources.list":
    owner   => root,
    group   => root,
    mode    => 644,
    source  => "puppet:///modules/debian/squeeze.list",
  }

  file { "/etc/apt/sources.list.d/squeeze-backports.list":
    owner   => root,
    group   => root,
    mode    => 644,
    source  => "puppet:///modules/debian/squeeze-backports.list",
  }

}

class debian::lenny {

  file { "/etc/apt/preferences":
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => 644,
    source  => "puppet:///modules/debian/puppet-pin",
  }

  file { "/etc/apt/sources.list":
    owner   => root,
    group   => root,
    mode    => 644,
    source  => "puppet:///modules/debian/lenny.list",
  }

}

class debian::fosiki {

  file { "/etc/apt/sources.list.d/fosiki.list":
    owner   => root,
    group   => root,
    mode    => 644,
    source  => "puppet:///modules/debian/fosiki.list",
  }

}

class debian::tivoli {

  file { "/etc/apt/sources.list.d/tivoli.list":
    owner   => root,
    group   => root,
    mode    => 644,
    source  => "puppet:///modules/debian/tivoli.list",
  }

}

class debian::karaage {

  apt::key { "vpac": 
    key        => "B8282F0123ACA808",
    key_source => "http://code.vpac.org/debian/vpac-debian-key.gpg",
  }

  file { "/etc/apt/sources.list.d/karaage.list":
    owner   => root,
    group   => root,
    mode    => 644,
    source  => "puppet:///modules/debian/karaage.list",
  }

}

class debian::megacli {

  file { "/etc/apt/sources.list.d/megacli.list":
    owner   => root,
    group   => root,
    mode    => 644,
    source  => "puppet:///modules/debian/megacli.list",
  }

  apt::key { "hwraid":
    key        => "6005210E23B3D3B4",
    key_source => "http://hwraid.le-vert.net/debian/hwraid.le-vert.net.gpg.key",
  }


}

class debian::mariadb {

  file { "/etc/apt/sources.list.d/mariadb.list":
    owner   => root,
    group   => root,
    mode    => 644,
    source  => "puppet:///modules/debian/mariadb.list",
  }

  file { "/etc/apt/preferences.d/mariadb-mysqlclient18":
    owner   => root,
    group   => root,
    mode    => 644,
    source  => "puppet:///modules/debian/preferences-mariadb-mysqlclient18",
  }

}

