class nrpe {

  $ver =  $operatingsystem ? {
    Debian => "$operatingsystem/$lsbdistcodename",
    CentOS => "$operatingsystem/$operatingsystemrelease",
    default => "$operatingsystem/$operatingsystemrelease"
  }

  $nrpe_user = $operatingsystem ? {
    Debian   => "nagios",
    CentOS   => "nrpe",
    RedHat   => "nrpe",
    default  => "nagios",
  }

  $nrpe_package = $operatingsystem ? {
    Debian   => "nagios-nrpe-server",
    CentOS   => "nrpe",
    RedHat	 => "nrpe",
  }

  package { "sysstat":
    ensure => installed,
  }

  package { "sudo":
    ensure => installed,
  }

  package { $nrpe_package:
    ensure => installed,
  }     

  # Create the NRPE conf dir
  file { "/etc/nagios":
    ensure => directory,
    owner  => root,
    group  => root,
    mode   => 755,
  }

  # Base config file
  file { "/etc/nagios/nrpe.cfg":
    owner   => root,
    group   => root,
    mode    => 644,
    source  => ["puppet:///modules/nrpe/$ver/nrpe.cfg", "puppet:///modules/nrpe/nrpe.cfg"],
  }

  # Create the NRPE conf dir
  file { "/etc/nagios/conf.d":
    ensure => directory,
    owner  => root,
    group  => root,
    mode   => 755,
  }

  # Create the Nagios dir
  file { "/usr/local/lib/nagios":
    ensure => directory,
    owner  => root,
    group  => root,
    mode   => 755,
  }

  # Create the Nagios plugins dir
  file { "/usr/local/lib/nagios/plugins":
    ensure => directory,
    owner  => root,
    group  => root,
    mode   => 755,
  }

  case $operatingsystem {
    Debian: { $temparch = "i686" }
    default: { $temparch = $hardwaremodel }
  }

  # Arch file
  file { "/etc/nagios/conf.d/nrpe_${hardwaremodel}.cfg":
    owner   => root,
    group   => root,
    mode    => 644,
    source  => ["puppet:///modules/nrpe/host-specific/${fqdn}/nrpe_arch.cfg", "puppet:///modules/nrpe/checks/nrpe_arch_${temparch}.cfg"],
  }

  # Check Mem
  file { "/usr/local/lib/nagios/plugins/check_mem.bash":
    owner   => root,
    group   => root,
    mode    => 755,
    source  => "puppet:///modules/nrpe/checks/check_mem.bash",
  }

  file { "/usr/local/lib/nagios/plugins/check_cpu.sh":
    owner   => root,
    group   => root,
    mode    => 755,
    source  => "puppet:///modules/nrpe/cpu/check_cpu.sh",
  }

  # Check Mem
  file { "/usr/local/lib/nagios/plugins/check_mem.pl":
    owner   => root,
    group   => root,
    mode    => 755,
    source  => "puppet:///modules/nrpe/checks/check_mem.pl",
  }

  # Load OS specifics
  case $operatingsystem {
    CentOS: { include nrpe::centos }
    RedHat: { include nrpe::centos }
    Debian: { include nrpe::debian }
    default: { err("No such operatingsystem: $operatingsystem not defined") }
  }

}

# CentOS NRPE Settings
class nrpe::centos {

  $nrpe_package = $operatingsystem ? {
    Debian   => "nagios-nrpe-server",
    CentOS   => "nrpe",
    RedHat	 => "nrpe",
  }

  package { ["nagios-plugins-disk", "nagios-plugins-load", "nagios-plugins-users", "nagios-plugins-procs", "nagios-plugins-perl", "nagios-plugins-file_age"]:
    ensure => installed,
  }

  $yumsecurity = $lsbmajdistrelease ? {
    4 => yum-security,
    5 => yum-security,
    6 => yum-plugin-security,
	undef => false,
  }

  # Make sure yum-priorites is installed
  if $yumsecurity {
	package { $yumsecurity:
	  ensure => installed,
      alias  => yum-security,
  	}
  }

  # Check Yum
  file { "/usr/local/lib/nagios/plugins/check_yum.py":
    owner   => root,
    group   => root,
    mode    => 755,
    source  => "puppet:///modules/nrpe/checks/check_yum.py",
  }

  # Arch file
  file { "/etc/nagios/conf.d/nrpe_check_yum.cfg":
    owner   => root,
    group   => root,
    mode    => 644,
    source  => "puppet:///modules/nrpe/checks/nrpe_check_yum.cfg",
    notify  => Service[$nrpe_package],
  }

  file { "/etc/nagios/conf.d/nrpe_check_puppet.cfg":
    owner   => root,
    group   => root,
    mode    => 644,
    source  => "puppet:///modules/nrpe/checks/nrpe_check_puppet_centos_${hardwaremodel}.cfg",
    notify  => Service[$nrpe_package],
  }
      
  # Arch file
  file { "/etc/nagios/conf.d/nrpe_check_mem.cfg":
    owner   => root,
    group   => root,
    mode    => 644,
    source  => "puppet:///modules/nrpe/checks/nrpe_check_mem.cfg",
    notify  => Service[$nrpe_package],
  }

  file { "/etc/nagios/conf.d/nrpe_check_cpu.cfg":
    owner   => root,
    group   => root,
    mode    => 644,
    source  => "puppet:///modules/nrpe/cpu/check_cpu.cfg",
    notify  => Service[$nrpe_package],
  }

  service { "nrpe":
    ensure     => running,
    enable     => true,
    hasrestart => false,
    require    => Package["nrpe"],
  }
}


# Debian NRPE Settings
class nrpe::debian {

  $nrpe_package = $operatingsystem ? {
    Debian   => "nagios-nrpe-server",
    CentOS   => "nrpe",
    RedHat	 => "nrpe",
  }

  # Packages
  package { "nagios-plugins-basic":
    ensure => installed,
  }
    
  # APT check config file
  file { "/etc/nagios/conf.d/nrpe_check_apt.cfg":
    owner   => root,
    group   => root,
    mode    => 644,
    source  => "puppet:///modules/nrpe/checks/nrpe_check_apt_${hardwaremodel}.cfg",
    notify  => Service[$nrpe_package],

  }
  file { "/etc/nagios/conf.d/nrpe_check_puppet.cfg":
    owner   => root,
    group   => root,
    mode    => 644,
    source  => "puppet:///modules/nrpe/checks/nrpe_check_puppet_debian_${hardwaremodel}.cfg",
    notify  => Service[$nrpe_package],
  }

  # Arch file
  file { "/etc/nagios/conf.d/nrpe_check_mem.cfg":
    owner   => root,
    group   => root,
    mode    => 644,
    source  => "puppet:///modules/nrpe/checks/nrpe_check_mem.cfg",
    notify  => Service[$nrpe_package],
  }

  file { "/etc/nagios/conf.d/nrpe_check_cpu.cfg":
    owner   => root,
    group   => root,
    mode    => 644,
    source  => "puppet:///modules/nrpe/cpu/check_cpu.cfg",
    notify  => Service[$nrpe_package],
  }

  # NRPE Server
  service { "nagios-nrpe-server":
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => false,
    pattern    => 'nrpe',
    require    => Package["nagios-nrpe-server"],
  }
}

class nrpe::gpfs {

  $nrpe_package = $operatingsystem ? {
    Debian   => "nagios-nrpe-server",
    CentOS   => "nrpe",
    RedHat	 => "nrpe",
  }

  # storage disk file, higher thresholds for free space disk check
  file { "/etc/nagios/conf.d/nrpe_gpfs.cfg":
    owner   => root,
    group   => root,
    mode    => 644,
    source  => "puppet:///modules/nrpe/nrpe_gpfs.cfg",
    notify  => Service[$nrpe_package],
  }

  file { "/etc/nagios/conf.d/nrpe_mmfsd.cfg":
    owner   => root,
    group   => root,
    mode    => 644,
    source  => "puppet:///modules/nrpe/nrpe_mmfsd.cfg",
    notify  => Service[$nrpe_package],
  }

}

class nrpe::sas2ircu {

  $nrpe_package = $operatingsystem ? {
    Debian   => "nagios-nrpe-server",
    CentOS   => "nrpe",
    RedHat	 => "nrpe",
  }

  package { "sas2ircu":
    ensure => installed,
  }

  # It's OK to install unsigned packages
  file { "/etc/apt/apt.conf.d/99auth":       
    owner     => root,
    group     => root,
    content   => "APT::Get::AllowUnauthenticated yes;",
    mode      => 644;
  }

  file { "/etc/nagios/conf.d/nrpe_check_sas2ircu.cfg":
    owner   => root,
    group   => root,
    mode    => 644,
    source  => "puppet:///modules/nrpe/sas2ircu/nrpe_check_sas2ircu.cfg",
    notify  => Service[$nrpe_package],
  }

  file { "/usr/local/lib/nagios/plugins/check_sas2ircu":
    owner   => root,
    group   => root,
    mode    => 755,
    source  => "puppet:///modules/nrpe/sas2ircu/check_sas2ircu",
  }

  file { "/etc/sudoers.d/sas2ircu":
    owner   => root,
    group   => root,
    mode    => 0440,
    source  => "puppet:///modules/nrpe/sas2ircu/sudoers",
  }

}

class nrpe::mysql {

  $nrpe_package = $operatingsystem ? {
    Debian   => "nagios-nrpe-server",
    CentOS   => "nrpe",
    RedHat	 => "nrpe",
  }

  file { "/etc/nagios/conf.d/nrpe_check_mysql_connections.cfg":
    owner   => root,
    group   => root,
    mode    => 644,
    source  => "puppet:///modules/nrpe/mysql/nrpe_check_mysql_connections.cfg",
    notify  => Service[$nrpe_package],
  }

  file { "/usr/local/lib/nagios/plugins/check_mysql_connections":
    owner   => root,
    group   => root,
    mode    => 755,
    source  => "puppet:///modules/nrpe/mysql/check_mysql_connections",
  }

  file { "/etc/sudoers.d/mysql":
    owner   => root,
    group   => root,
    mode    => 0440,
    source  => "puppet:///modules/nrpe/mysql/sudoers",
  }

}

class nrpe::drbd {

  $nrpe_package = $operatingsystem ? {
    Debian   => "nagios-nrpe-server",
    CentOS   => "nrpe",
    RedHat	 => "nrpe",
  }

  file { "/etc/nagios/conf.d/nrpe_check_drbd.cfg":
    owner   => root,
    group   => root,
    mode    => 644,
    source  => "puppet:///modules/nrpe/drbd/nrpe_check_drbd.cfg",
    notify  => Service[$nrpe_package],
  }

  file { "/usr/local/lib/nagios/plugins/check_drbd":
    owner   => root,
    group   => root,
    mode    => 755,
    source  => "puppet:///modules/nrpe/drbd/check_drbd",
  }

}

class nrpe::proxmox {

  $nrpe_package = $operatingsystem ? {
    Debian   => "nagios-nrpe-server",
    CentOS   => "nrpe",
    RedHat	 => "nrpe",
  }

  file { "/etc/nagios/conf.d/nrpe_check_proxmox.cfg":
    owner   => root,
    group   => root,
    mode    => 644,
    source  => "puppet:///modules/nrpe/proxmox/nrpe_check_proxmox.cfg",
    notify  => Service[$nrpe_package],
  }

}

class nrpe::ldap {

  $nrpe_package = $operatingsystem ? {
    Debian   => "nagios-nrpe-server",
    CentOS   => "nrpe",
    RedHat	 => "nrpe",
  }

  file { "/etc/nagios/conf.d/nrpe_check_ldap.cfg":
    owner   => root,
    group   => root,
    mode    => 644,
    source  => "puppet:///modules/nrpe/ldap/nrpe_check_ldap.cfg",
    notify  => Service[$nrpe_package],
  }

}

class nrpe::cluster {

  $nrpe_package = $operatingsystem ? {
    Debian   => "nagios-nrpe-server",
    CentOS   => "nrpe",
    RedHat	 => "nrpe",
  }

  file { "/etc/nagios/conf.d/nrpe_check_usr_local_src.cfg":
    owner   => root,
    group   => root,
    mode    => 644,
    source  => "puppet:///modules/nrpe/cluster/check_usr_local_src.cfg",
    notify  => Service[$nrpe_package],
  }

  file { "/usr/local/lib/nagios/plugins/check_usr_local_src.bash":
    owner   => root,
    group   => root,
    mode    => 755, 
    source  => "puppet:///modules/nrpe/cluster/check_usr_local_src.bash",
  }

  file { "/etc/nagios/conf.d/nrpe_check_devnull.cfg":
    owner   => root,
    group   => root,
    mode    => 644,
    source  => "puppet:///modules/nrpe/cluster/check_devnull.cfg",
    notify  => Service[$nrpe_package],
  }

  file { "/usr/local/lib/nagios/plugins/check_devnull.bash":
    owner   => root,
    group   => root,
    mode    => 755, 
    source  => "puppet:///modules/nrpe/cluster/check_devnull.bash",
  }

  file { "/etc/nagios/conf.d/nrpe_check_torque.cfg":
    owner   => root,
    group   => root,
    mode    => 644,
    source  => "puppet:///modules/nrpe/cluster/check_torque.cfg",
    notify  => Service[$nrpe_package],
  }

  file { "/usr/local/lib/nagios/plugins/check_torque.bash":
    owner   => root,
    group   => root,
    mode    => 755, 
    source  => "puppet:///modules/nrpe/cluster/check_torque.bash",
  }

  file { "/etc/nagios/conf.d/nrpe_check_slurm.cfg":
    owner   => root,
    group   => root,
    mode    => 644,
    source  => "puppet:///modules/nrpe/cluster/check_slurm.cfg",
    notify  => Service[$nrpe_package],
  }

  file { "/etc/nagios/conf.d/nrpe_check_slurm_nodes.cfg":
    owner   => root,
    group   => root,
    mode    => 644,
    source  => "puppet:///modules/nrpe/cluster/check_slurm_nodes.cfg",
    notify  => Service[$nrpe_package],
  }

  file { "/etc/nagios/conf.d/nrpe_check_srun.cfg":
    owner   => root,
    group   => root,
    mode    => 644,
    source  => "puppet:///modules/nrpe/cluster/check_srun.cfg",
    notify  => Service[$nrpe_package],
  }

  file { "/etc/sudoers.d/srun":
    owner   => root,
    group   => root,
    mode    => 0440,
    source  => "puppet:///modules/nrpe/cluster/sudoers_srun",
  }

  file { "/usr/local/lib/nagios/plugins/check_slurm.bash":
    owner   => root,
    group   => root,
    mode    => 755, 
    source  => "puppet:///modules/nrpe/cluster/check_slurm.bash",
  }

  file { "/etc/nagios/conf.d/nrpe_check_scope.cfg":
    owner   => root,
    group   => root,
    mode    => 644,
    source  => "puppet:///modules/nrpe/cluster/check_scope.cfg",
    notify  => Service[$nrpe_package],
  }

  file { "/usr/local/lib/nagios/plugins/check_scope.bash":
    owner   => root,
    group   => root,
    mode    => 755, 
    source  => "puppet:///modules/nrpe/cluster/check_scope.bash",
  }

  file { "/etc/sudoers.d/rvitals":
    owner   => root,
    group   => root,
    mode    => 0440,
    source  => "puppet:///modules/nrpe/cluster/sudoers_rvitals",
  }

  file { "/etc/nagios/conf.d/nrpe_check_rvitals.cfg":
    owner   => root,
    group   => root,
    mode    => 644,
    source  => "puppet:///modules/nrpe/cluster/check_rvitals.cfg",
    notify  => Service[$nrpe_package],
  }

  file { "/usr/local/lib/nagios/plugins/check_rvitals.bash":
    owner   => root,
    group   => root,
    mode    => 755, 
    source  => ["puppet:///modules/nrpe/cluster/${fqdn}/check_rvitals.bash", "puppet:///modules/nrpe/cluster/check_rvitals.bash"],
  }

  file { "/etc/nagios/conf.d/nrpe_check_motd.cfg":
    owner   => root,
    group   => root,
    mode    => 644,
    source  => "puppet:///modules/nrpe/cluster/check_motd.cfg",
    notify  => Service[$nrpe_package],
  }

  file { "/usr/local/lib/nagios/plugins/check_motd.bash":
    owner   => root,
    group   => root,
    mode    => 755, 
    source  => "puppet:///modules/nrpe/cluster/check_motd.bash",
  }

  file { "/etc/nagios/conf.d/nrpe_check_moab.cfg":
    owner   => root,
    group   => root,
    mode    => 644,
    source  => "puppet:///modules/nrpe/cluster/check_moab.cfg",
    notify  => Service[$nrpe_package],
  }

  file { "/usr/local/lib/nagios/plugins/check_moab.bash":
    owner   => root,
    group   => root,
    mode    => 755, 
    source  => "puppet:///modules/nrpe/cluster/check_moab.bash",
  }

  file { "/etc/nagios/conf.d/nrpe_check_project_directories.cfg":
    owner   => root,
    group   => root,
    mode    => 644,
    source  => "puppet:///modules/nrpe/cluster/check_project_directories.cfg",
    notify  => Service[$nrpe_package],
  }

  file { "/etc/nagios/conf.d/nrpe_check_quota.cfg":
    owner   => root,
    group   => root,
    mode    => 644,
    source  => ["puppet:///modules/nrpe/cluster/${fqdn}/check_quota.cfg", "puppet:///modules/nrpe/cluster/check_quota.cfg"],
    notify  => Service[$nrpe_package],
  }

  file { "/etc/nagios/conf.d/nrpe_check_sshare.cfg":
    owner   => root,
    group   => root,
    mode    => 644,
    source  => "puppet:///modules/nrpe/cluster/check_sshare.cfg",
    notify  => Service[$nrpe_package],
  }

  file { "/etc/nagios/conf.d/nrpe_check_phi.cfg":
    owner   => root,
    group   => root,
    mode    => 644,
    source  => "puppet:///modules/nrpe/cluster/check_phi.cfg",
    notify  => Service[$nrpe_package],
  }

  file { "/usr/local/lib/nagios/plugins/check_phi.bash":
    owner   => root,
    group   => root,
    mode    => 755, 
    source  => "puppet:///modules/nrpe/cluster/check_phi.bash",
  }


}

class nrpe::named {

  $nrpe_package = $operatingsystem ? {
    Debian   => "nagios-nrpe-server",
    CentOS   => "nrpe",
    RedHat	 => "nrpe",
  }

  file { "/etc/nagios/conf.d/nrpe_named.cfg":
    owner   => root,
    group   => root,
    mode    => 644,
    source  => "puppet:///modules/nrpe/named/nrpe_named.cfg",
    notify  => Service[$nrpe_package],
  }

  file { "/usr/local/lib/nagios/plugins/check_bind.sh":
    owner   => root,
    group   => root,
    mode    => 755,
    source  => "puppet:///modules/nrpe/named/check_bind.sh",
  }

  file { "/etc/sudoers.d/named":
    owner   => root,
    group   => root,
    mode    => 0440,
    source  => "puppet:///modules/nrpe/named/sudoers",
  }

}

class nrpe::panasas {

  $nrpe_package = $operatingsystem ? {
    Debian   => "nagios-nrpe-server",
    CentOS   => "nrpe",
    RedHat	 => "nrpe",
  }

  file { "/etc/nagios/conf.d/nrpe_check_panasas.cfg":
    owner   => root,
    group   => root,
    mode    => 644,
    source  => "puppet:///modules/nrpe/panasas/nrpe_check_panasas.cfg",
    notify  => Service[$nrpe_package],
  }

}

class nrpe::gold {

  $nrpe_package = $operatingsystem ? {
    Debian   => "nagios-nrpe-server",
    CentOS   => "nrpe",
    RedHat	 => "nrpe",
  }

  file { "/etc/nagios/conf.d/nrpe_check_gold.cfg":
    owner   => root,
    group   => root,
    mode    => 644,
    source  => "puppet:///modules/nrpe/gold/nrpe_check_gold.cfg",
    notify  => Service[$nrpe_package],
  }

}

class nrpe::slurmdbd {

  $nrpe_package = $operatingsystem ? {
    Debian   => "nagios-nrpe-server",
    CentOS   => "nrpe",
    RedHat	 => "nrpe",
  }

  file { "/etc/nagios/conf.d/nrpe_check_slurmdbd.cfg":
    owner   => root,
    group   => root,
    mode    => 644,
    source  => "puppet:///modules/nrpe/slurmdbd/nrpe_check_slurmdbd.cfg",
    notify  => Service[$nrpe_package],
  }

}

