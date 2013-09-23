class patchman {

   file { "/etc/patchman":
        ensure  => directory,
        owner   => root,
        group   => root,
        mode    => 755,
   }

   file { "/usr/local/sbin/patchman-client":
       source  => ["puppet:///modules/patchman/${fqdn}/patchman-client", "puppet:///modules/patchman/patchman-client"],
       owner  => root,
       group  => adm,
       mode   => 750,
   }

    cron { "patchman":
        ensure  => present,
        command => "/bin/sleep $((RANDOM\\%600)); PATH=/bin:/sbin:/usr/bin:/usr/sbin /usr/local/sbin/patchman-client",
        user    => 'root',
        minute  => '00',
        hour    => '5',
   }

   file { "/etc/patchman/patchman-client.conf":
         source  => "puppet:///modules/patchman/patchman-client.conf",
         owner  => root,
         group  => root,
         mode   => 600,
   }

}
