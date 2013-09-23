# centos specific things

class centos {

  if $update_yum {
     include centos::yum
  }

  $version = $operatingsystemrelease ? {
    default => "5",
  }


  # Automatically update the Yum cache
  cron { "yum-makecache":
    ensure 	=> present,
    command	=> "/usr/bin/yum -q clean all && /usr/bin/yum -q makecache",
    user 	=> root,
    weekday => 0,
    hour    => 10,
    minute	=> fqdn_rand(60),
  }

  # Make sure GPM is not running
  service { "gpm":
    ensure => stopped,
    enable => false,
  }
  
  # Remove these 
  package { ["bluez-hcidump", "bluez-gnome", "bluez-libs", "bluez-utils"]: # , "redhat-lsb", "cups", "poppler", "poppler-utils"]:
    ensure => absent
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

  package { "logwatch":
    ensure  => installed,
  }

}

class centos::yum {

  file { "/etc/yum.repos.d/CentOS-Base.repo":
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => 644,
    source  => "puppet:///modules/centos/CentOS-Base.repo",
  }

  file { "/etc/yum.repos.d/puppet.repo":
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => 644,
    source  => "puppet:///modules/centos/puppet.repo",
  }

  # Install the EPEL Repo
  file { "/etc/yum.repos.d/epel.repo":
    owner   => root,
    group   => root,
    mode    => 644,
    content => template("centos/epel.erb"),
  }

}
