class motd {

#        $ascii = generate('/bin/sh', '-c', "/usr/bin/figlet -c -w 60 ${hostname}")

        file { 'motd':
            name    => '/etc/motd',
            mode    => '0664',
            owner   => 'root',
            group   => 'root',
            content => template('motd/motd.erb')
        }
}
