class os-base {

  case $operatingsystem {
    Debian:  { include debian }
    CentOS:  { include centos }
  }

}
              
