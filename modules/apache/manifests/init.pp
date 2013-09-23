class apache {

  $apache = $operatingsystem ? {
    Debian   => "apache2",
    CentOS   => "httpd",
    default  => "apache2"
  }

  package { $apache:
    ensure => installed
  }

  service { $apache:
    ensure  => running,
    enable  => true,
    require => Package[$apache]
  }

  file {"/etc/$apache/services":
    ensure => directory,
  }
  
}

class apache::standard inherits apache {

}     
  

class apache::ssl inherits apache {

  file { "/etc/$apache/ssl":
    ensure => directory,
  }
  
  file {"/etc/$apache/ssl/IPS-IPSCABUNDLE.CRT":
	ensure => absent
  }

  file {"/etc/$apache/ssl/startssl-class1-ca.pem":
    owner   => root,
    group   => root,
    mode    => 644,
    source  => "puppet:///modules/apache/startssl-class1-ca.pem",
    require => Package[$apache],
  }

  file {"/etc/$apache/ssl/ipsca-request.sh":
    ensure => absent
  }


}
