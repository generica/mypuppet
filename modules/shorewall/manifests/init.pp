class shorewall  {

#  $shib_package = $operatingsystem ? {
#    Debian   => "libapache2-mod-shib2",
#    CentOS   => "shibboleth",
#  }
        
  package { ['shorewall', 'shorewall-perl']:
    ensure => installed,
  }

  service {'shorewall':
    ensure     => running,
#    enabled    => true,
    hasrestart => true,
    status     => '/sbin/shorewall status',
  }
    
  file { "/etc/shorewall/shorewall.conf":
    owner   => root,
    group   => root,
    mode    => 644,
    source  => "puppet:///modules/shorewall/shorewall.conf",
    require => Package['shorewall'],
    notify  => Service['shorewall'],
  }

  file { "/etc/default/shorewall":
    owner   => root,
    group   => root,
    mode    => 644,
    source  => "puppet:///modules/shorewall/debian-default",
    require => Package['shorewall'],
    notify  => Service['shorewall'],
  }

  file { "/etc/shorewall/hosts":
    owner   => root,
    group   => root,
    mode    => 644,
    source  => "puppet:///modules/shorewall/hosts",
    require => Package[shorewall],
    notify  => Service['shorewall'],
  }

  file { "/etc/shorewall/interfaces":
    owner   => root,
    group   => root,
    mode    => 644,
    source  => "puppet:///modules/shorewall/interfaces",
    require => Package[shorewall],
    notify  => Service['shorewall'],
  }

  file { "/etc/shorewall/interfaces2":
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => 644,
    content => template("shorewall/interfaces.erb"),
    require => Package[shorewall],
    notify  => Service['shorewall'],
  }

  file { "/etc/shorewall/policy":
    owner   => root,
    group   => root,
    mode    => 644,
    source  => "puppet:///modules/shorewall/policy",
    require => Package[shorewall],
    notify  => Service['shorewall'],
  }


  file { "/etc/shorewall/zones":
    owner   => root,
    group   => root,
    mode    => 644,
    source  => "puppet:///modules/shorewall/zones",
    require => Package[shorewall],
    notify  => Service['shorewall'],
  }

  file { "/etc/shorewall/rules":
    owner   => root,
    group   => root,
    mode    => 644,
    source  => "puppet:///modules/shorewall/rules",
    require => Package[shorewall],
    notify  => Service['shorewall'],
  }

  file { "/etc/shorewall/rules.d":
    ensure  => directory,
    owner   => root,
    group   => root,
    mode    => 755,
    require => Package[shorewall],
    notify  => Service['shorewall'],
  }

  file {"/var/log/shorewall":
    ensure => directory,
  }
  
}

class shorewall::http inherits shorewall {

  file { "/etc/shorewall/rules.d/http.rules":
    owner   => root,
    group   => root,
    mode    => 644,
    source  => "puppet:///modules/shorewall/rules.d/http.rules",
    require => Package[shorewall],
    notify  => Service['shorewall'],
  }
  
}

class shorewall::https inherits shorewall {

  file { "/etc/shorewall/rules.d/https.rules":
    owner   => root,
    group   => root,
    mode    => 644,
    source  => "puppet:///modules/shorewall/rules.d/https.rules",
    require => Package[shorewall],
    notify  => Service['shorewall'],
  }
  
}
class shorewall::ejabberd inherits shorewall {

  file { "/etc/shorewall/rules.d/https.rules":
    owner   => root,
    group   => root,
    mode    => 644,
    source  => "puppet:///modules/shorewall/rules.d/ejabberd.rules",
    require => Package[shorewall],
    notify  => Service['shorewall'],
  }
  
}

class shorewall::web-service inherits shorewall {

  file { "/etc/shorewall/rules.d/web-service.rules":
    owner   => root,
    group   => root,
    mode    => 644,
    source  => "puppet:///modules/shorewall/rules.d/web-service.rules",
    require => Package[shorewall],
    notify  => Service['shorewall'],
  }
  
}
class shorewall::ssh inherits shorewall {

  file { "/etc/shorewall/rules.d/ssh.rules":
    owner   => root,
    group   => root,
    mode    => 644,
    source  => "puppet:///modules/shorewall/rules.d/ssh.rules",
    require => Package[shorewall],
    notify  => Service['shorewall'],
  }
  
}
class shorewall::git inherits shorewall {

  file { "/etc/shorewall/rules.d/git.rules":
    owner   => root,
    group   => root,
    mode    => 644,
    source  => "puppet:///modules/shorewall/rules.d/git.rules",
    require => Package[shorewall],
    notify  => Service['shorewall'],
  }
  
}
