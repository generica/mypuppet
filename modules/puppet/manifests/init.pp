class puppet {
        
  $config_file = $operatingsystem ? {
    Debian => "/etc/default/puppet",
    CentOS => "/etc/sysconfig/puppet",
    RedHat => "/etc/sysconfig/puppet",
  }
  
  case $puppetversion {
    "0.24.4": { include puppet::cron }
    "0.24.5": { include puppet::cron }
    "0.24.6": { include puppet::cron }
    "0.24.7": { include puppet::cron }
    "0.24.8": { include puppet::cron }
    "0.24.4-8~bpo40+1" : { include puppet::cron }
    default: { include puppet::cron }
  }

  # Cron check for puppet running
  file { "/etc/cron.hourly/check_puppet":
    ensure => absent,
    owner  => root,
    group  => root,
    mode   => 744,
    source => "puppet:///modules/puppet/check_puppet",
  }

  # remove /var/lib/puppet/clientbucket backup files older than 4 weeks
  tidy { "/var/lib/puppet/clientbucket":
    age     => "1w",
    recurse => true,
    matches => [ "*" ]
  }

  file { "/var/lib/puppet/lib/facter/rootsshkey.rb":
    ensure => absent,
    force => true,
  }

}

class puppet::service {

  cron { "puppet":
    ensure  => absent,
    command => "/bin/sleep $((RANDOM\\%600)); /usr/bin/puppet agent --onetime --no-daemonize 2>&1",
    user    => 'root',
    minute  => '*/20'
  }
  
  service { "puppet":
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
    subscribe  => [ File["/etc/puppet/puppet.conf"] ],
    #pattern		=> "agent agent",
  }

  file { $config_file:
    source   => $operatingsystem ? {
      Debian => "puppet:///modules/puppet/config-service",
      CentOS => "puppet:///modules/puppet/centos-sysconfig",
      RedHat => "puppet:///modules/puppet/centos-sysconfig",
    },
    notify => Service[puppet],
  }

  case $operatingsystem {
    Debian: { include puppet::debian }
    CentOS: { include puppet::centos }
    RedHat: { include puppet::redhat }
  }
}

class puppet::cron {

  package { "puppet":
    ensure => installed,
  }

  cron { "puppet":
    ensure  => present,
    command => "/bin/sleep $((RANDOM\\%600)); /usr/bin/puppet agent --onetime --no-daemonize 2>&1",
    user    => 'root',
    minute  => '*/20'
  }

  service { "puppet":
    status     => "service puppet status",
    ensure     => stopped,
    enable     => false,
    hasrestart => true,
    require    => Package["puppet"],
  }      
  
  file { $config_file:
    source   => $operatingsystem ? {
      Debian => "puppet:///modules/puppet/config-cron",
      CentOS => "puppet:///modules/puppet/centos-sysconfig",
      RedHat => "puppet:///modules/puppet/centos-sysconfig",
    },
  }
  
  file { "/etc/puppet/puppet.conf":
    source  => ["puppet:///modules/puppet/${fqdn}-puppet.conf", "puppet:///modules/puppet/puppet.conf" ],
  }

}

class puppet::debian {
  
  case $lsbdistcodename {
    lenny: { include puppet::debian::lenny }
    squeeze: { include puppet::debian::squeeze }
    default: { include puppet::default }
  }

  cron { "restart-puppet":
    command => "/etc/init.d/puppet restart >/dev/null 2>&1",
    user => root,
    hour => 2,
    minute => 0
  }

}

class puppet::debian::lenny {

  package { puppet:
    ensure => "2.6.2-4~bpo50+1",
  }
  
  package { puppet-common:
    ensure => "2.6.2-4~bpo50+1",
  }
  
  file { "/etc/puppet/puppet.conf":
    source => ["puppet:///modules/puppet/${fqdn}-puppet.conf", "puppet:///modules/puppet/puppet-2.6.conf" ],
    notify => Service[puppet],
  }

  # Remove 0.25 PID files
  file { "/var/run/puppet/puppetd.pid":
    ensure => absent,
  }
  
}

class puppet::debian::squeeze {

  package { puppet:
    ensure => "2.6.2-4",
  }

  package { puppet-common:
    ensure => "2.6.2-4",
  }

  file { "/etc/puppet/puppet.conf":
    source  => ["puppet:///modules/puppet/${fqdn}-puppet.conf", "puppet:///modules/puppet/puppet-2.6.conf" ],
    notify  => Service[puppet],
  }

  # Remove 0.25 PID files
  file { "/var/run/puppet/puppetd.pid":
    ensure => absent,
  }

}

class puppet::centos {

  yumrepo { "epel-puppet":
    baseurl  => "http://tmz.fedorapeople.org/repo/puppet/epel/5/\$basearch/",
    descr    => "epel-puppet",
    enabled  => 1,
    gpgcheck => 0
  }

  # Remove 0.25 PID files
  #  file { "/var/run/puppet/puppetd.pid":
  #    ensure => absent,
  #  }
  
  package { "puppet":
    ensure => "2.6.4-0.5.el5",
    notify => Service[puppet],
  }

  file { "/etc/puppet/puppet.conf":
    source => ["puppet:///modules/puppet/${fqdn}-puppet.conf", "puppet:///modules/puppet/puppet-2.6.conf" ],
    notify => Service[puppet],
  }

# hacky fix to rename agent.pid to puppetd.pid in puppet 2.6.3 initscript
# will hopefully be fixed in a later rpm, then we can update the version above 
# and remove/reverse this
  #exec { "rename-puppet-pid":
#	command => "/bin/sed -i -e 's/puppetd.pid/agent.pid/' /etc/init.d/puppet",
#	notify => Service[puppet],
#  }

  #exec { "hard-restart-puppet":
  #  command => "/bin/kill `/bin/cat /var/run/puppet/puppetd.pid` && /bin/rm /var/run/puppet/puppetd.pid || /bin/true",
  #  notify => Service[puppet],
  #}

}

class puppet::redhat {

  package { "puppet":
    ensure => installed,
  }

  file { "/etc/puppet/puppet.conf":
    source => ["puppet:///modules/puppet/${fqdn}-puppet.conf", "puppet:///modules/puppet/puppet.conf" ],
    notify => Service[puppet],
  }
  
  #exec { fedora-yum-upgrade: command => "/usr/bin/yum -y upgrade", }
  
}

class puppet::default {

  package { "puppet":
    ensure => installed,
  }
  
  file { "/etc/puppet/puppet.conf":
    source => ["puppet:///modules/puppet/${fqdn}-puppet.conf", "puppet:///modules/puppet/puppet.conf" ],
    notify => Service[puppet],
  }
  
}
