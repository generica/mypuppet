class syslog {

define line($file, $line, $ensure = 'present') {
    case $ensure {
        default : { err ( "unknown ensure value ${ensure}" ) }
        present: {
            exec { "/bin/echo '${line}' >> '${file}'":
                unless => "/bin/grep -qFx '${line}' '${file}'"
            }
        }
        absent: {
            exec { "/usr/bin/perl -ni -e 'print unless /^\\Q${line}\\E\$/' '${file}'":
                onlyif => "/bin/grep -qFx '${line}' '${file}'"
            }
        }
    }
}


    package { rsyslog:
      ensure => installed,
    }

    package { sysklogd:
      ensure => absent,
    }	

#    file { "/etc/rsyslog.conf":
#      owner => root,
#      group => root,
#      content => "\$IncludeConfig /etc/rsyslog.d/",
#      ensure => file,
#      require => package["rsyslog"],
#      notify => service["rsyslog"]
#    }

    line { rsyslog:
      file => "/etc/rsyslog.conf",
      line => "\$IncludeConfig /etc/rsyslog.d/*.conf"
    }


    file { "/etc/rsyslog.d":
      ensure => directory,
    }

    service { "rsyslog":
      enable => true,
      ensure => running
    }

   class vlsci inherits syslog {

      file { "/etc/rsyslog.d/splunk.conf":
        owner  => root,
        group  => root,
        mode   => 400,
        source => "puppet:///modules/syslog/splunk.conf",
      }
   }
}
