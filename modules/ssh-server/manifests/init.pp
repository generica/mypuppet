class ssh-server {

  $sshd = $operatingsystem ? {
    Debian  => ssh,
    default => sshd
  }
  
  $ver =  $operatingsystem ? {
    Debian => $lsbdistcodename,
    CentOS => $operatingsystemrelease, 
    default => $operatingsystemrelease
  }

  package { openssh-server:
    ensure => installed
  }
  
  service { $sshd:
    ensure     => running,
    enable     => true,
    hasrestart => true,
    require    => Package[openssh-server],
    subscribe  => File["/etc/ssh/sshd_config"]
  }

  file { "/etc/ssh/sshd_config":
    owner  => root,
    group  => root,
    mode   => 600
  }

  file { "/etc/ssh/ssh_config":
    owner  => root,
    group  => root,
    mode   => 644
  }

  File["/etc/ssh/ssh_config"] { 
    source => "puppet:///modules/ssh-server/ssh_config" 
  }

}

class sshd-root-only inherits ssh-server {

  File["/etc/ssh/sshd_config"] { 
    source => "puppet:///modules/ssh-server/${operatingsystem}/${ver}/sshd_config-root_only" 
  }

}

class sshd-root-www-only inherits ssh-server {

  File["/etc/ssh/sshd_config"] { 
    source => "puppet:///modules/ssh-server/${operatingsystem}/${ver}/sshd_config-root-www_only" 
  }

}

class sshd-keys-only inherits ssh-server {
 
 File["/etc/ssh/sshd_config"] { 
    source => "puppet:///modules/ssh-server/${operatingsystem}/${ver}/sshd_config-keys_only" 
 }

}
