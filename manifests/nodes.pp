# nodes.pp
#

node basenode_nomotd {
  $contact_groups = false
  $update_yum = false
  include baseclass
}

node basenode {
  $contact_groups = false
  $update_yum = true
  include baseclass
}

node clusternode inherits basenode_nomotd {
  $is_production = true
  include nrpe
  include puppet
  include patchman
}

node servernode inherits basenode {
  $contact_groups = 'systems-admins'
  $is_production = true
  include nrpe
  include puppet
  include ssh-server
  include admins::systems-team
  include patchman
  include motd
}

node proxmoxnode1 inherits servernode {
  $postfix_relayhost = "help.vlsci.unimelb.edu.au"
  $root_mail_recipient = "root@help.vlsci.unimelb.edu.au"
  include postfix
  postfix::config { "myorigin": value => "help.vlsci.unimelb.edu.au"; "myhostname":   value => "${fqdn}"; "relayhost": value => $postfix_relayhost; "root_mail_recipient": value => $root_mail_recipient; }
  include sshd-root-only
  include proxmox::proxmox1
  include nrpe::proxmox
  include mcelog
}

node proxmoxnode3 inherits servernode {
  $postfix_relayhost = "help.vlsci.unimelb.edu.au"
  $root_mail_recipient = "root@help.vlsci.unimelb.edu.au"
  include postfix
  postfix::config { "myorigin": value => "help.vlsci.unimelb.edu.au"; "myhostname":   value => "${fqdn}"; "relayhost": value => $postfix_relayhost; "root_mail_recipient": value => $root_mail_recipient; }
  include sshd-root-only
  include proxmox::proxmox3
  include nrpe::proxmox
  include mcelog
}

node dbnode inherits servernode {
  $postfix_relayhost = "help.vlsci.unimelb.edu.au"
  $root_mail_recipient = "root@help.vlsci.unimelb.edu.au"
  include postfix
  postfix::config { "myorigin": value => "help.vlsci.unimelb.edu.au"; "myhostname":   value => "${fqdn}"; "relayhost": value => $postfix_relayhost; "root_mail_recipient": value => $root_mail_recipient; }
  include sshd-root-only
}

node default inherits basenode {
}

node servernode_vm inherits servernode {
  $postfix_relayhost = "help.vlsci.unimelb.edu.au"
  $root_mail_recipient = "root@help.vlsci.unimelb.edu.au"
  include postfix
  postfix::config { "myorigin": value => "help.vlsci.unimelb.edu.au"; "myhostname":   value => "${fqdn}"; "relayhost": value => $postfix_relayhost; "root_mail_recipient": value => $root_mail_recipient; }
  include syslog::vlsci
}

node 'proxmox2.vlsci.unimelb.edu.au' inherits proxmoxnode1 {
  include debian::tivoli
}

node 'proxmox1.vlsci.unimelb.edu.au', 'proxmox3.vlsci.unimelb.edu.au' inherits proxmoxnode1 {
}

node 'proxmox4.vlsci.unimelb.edu.au', 'proxmox5.vlsci.unimelb.edu.au', 'proxmox6.vlsci.unimelb.edu.au' inherits proxmoxnode3 {
  include debian::megacli
  include nrpe::sas2ircu
  include nrpe::drbd
}

node 'www-test.vlsci.unimelb.edu.au' inherits servernode_vm {
  include web-server
  include sshd-root-www-only
  include debian::fosiki
  include nrpe::mysql
}

node 'hosting.vlsci.unimelb.edu.au' inherits servernode_vm {
  include web-server
  include sshd-root-only
  include nrpe::mysql
}

node 'static.vlsci.unimelb.edu.au' inherits servernode_vm {
#  include web-server
# No, since we're using nginx
  include sshd-root-www-only
  include debian::fosiki
}

node 'ldap.vlsci.unimelb.edu.au', 'ldap2.vlsci.unimelb.edu.au' inherits servernode_vm {
  include sshd-root-only
  include nrpe::ldap
}

node 'patchman.vlsci.unimelb.edu.au' inherits servernode_vm {
  include sshd-root-only
  include debian::karaage
}

node 'bronze.vlsci.unimelb.edu.au' inherits servernode_vm {
  include sshd-root-only
  include centos::yum
}

node 'db0.vlsci.unimelb.edu.au', 'db1.vlsci.unimelb.edu.au', 'db2.pcf.vlsci.unimelb.edu.au' inherits dbnode {
  include sshd-root-only
  include debian::tivoli
  include nrpe::mysql
  include mcelog
}

node 'db5.vlsci.unimelb.edu.au' inherits dbnode {
  include sshd-root-only
  include debian::tivoli
  include debian::mariadb
  include galera
  include nrpe::mysql
}

node 'db3.vlsci.unimelb.edu.au', 'db4.vlsci.unimelb.edu.au' inherits dbnode {
  include sshd-root-only
  include debian::tivoli
  include debian::mariadb
  include debian::megacli
  include nrpe::sas2ircu
  include nrpe::mysql
  include galera
  include mcelog
}

node 'bruce-grid.vlsci.unimelb.edu.au' inherits servernode_vm {
  include sshd-root-only
  include not-sam
}
              
node 'puppet.vlsci.unimelb.edu.au' inherits servernode_vm {
  include sshd-root-only
  include icinga
}

node 'slurm.vlsci.unimelb.edu.au' inherits servernode_vm {
#### Needs to be keys only to allow Mark to test as a user.
#  include sshd-root-only
  include sshd-keys-only
  include mark, jeff
  include nrpe::mysql
}
              
node 'slurm-dev.vlsci.unimelb.edu.au' inherits servernode_vm {
#### Needs to be keys only to allow Mark to test as a user.
#  include sshd-root-only
  include sshd-keys-only
  include mark, james, jeff
  include nrpe::mysql
}
              
node 'gold.vlsci.unimelb.edu.au' inherits servernode_vm {
#### Needs to be keys only to allow Mark to test as a user.
#  include sshd-root-only
  include sshd-keys-only
  include mark, jeff
  include aisaac
  include nrpe::slurmdbd
  include nrpe::gold
}
              
node 'kg-dev.vlsci.unimelb.edu.au' inherits servernode_vm {
  include sshd-root-only
  include not-sam, aisaac
  include debian::karaage
  include nrpe::mysql
}

node 'git.vlsci.unimelb.edu.au' inherits servernode_vm {
  include sshd-keys-only
  include not-sam, aisaac
}
        
# Don't want aliases modified, so don't use servernode_vm
node 'help.vlsci.unimelb.edu.au' inherits servernode { 
  include sshd-root-only
  include aisaac
  include debian::karaage
  include debian::squeeze-updates
}

node 'bruce-m.vlsci.unimelb.edu.au', 'bruce-m.pcf.vlsci.unimelb.edu.au' inherits clusternode {
  include nrpe::ldap
  include nrpe::cluster
  include nrpe::panasas
  include mcelog
}

node 'bruce.vlsci.unimelb.edu.au', 'merri.pcf.vlsci.unimelb.edu.au', 'barcoo.vlsci.unimelb.edu.au' inherits clusternode {
  include nrpe::cluster
  include mcelog
}

node 'merri-m.pcf.vlsci.unimelb.edu.au', 'barcoo-m.vlsci.unimelb.edu.au' inherits clusternode {
  include nrpe::gpfs
  include nrpe::ldap
  include nrpe::cluster
  include mcelog
}

node 'imgr.pcf.vlsci.unimelb.edu.au', 'imgr.vlsci.unimelb.edu.au' inherits servernode {
  include admins::ibm-systems-team
  include sshd-keys-only
  include nrpe::ldap
  include nrpe::cluster
  include icinga
  include mcelog
}

node 'dns01.pcf.vlsci.unimelb.edu.au', 'dns02.pcf.vlsci.unimelb.edu.au' inherits servernode {
  $postfix_relayhost = "help.vlsci.unimelb.edu.au"
  $root_mail_recipient = "root@help.vlsci.unimelb.edu.au"
  include postfix
  postfix::config { "myorigin": value => "help.vlsci.unimelb.edu.au"; "myhostname":   value => "${fqdn}"; "relayhost": value => $postfix_relayhost; "root_mail_recipient": value => $root_mail_recipient; }
  include nrpe::named
  include bind
  include mcelog
}

node 'panhandle.vlsci.unimelb.edu.au' inherits servernode {
  include nrpe::panasas
  include mcelog
}
