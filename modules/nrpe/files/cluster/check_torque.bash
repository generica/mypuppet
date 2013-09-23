#!/bin/bash
# SYNOPSIS
#       check_pbssched [<TCP port>] [<TCP port>] ...
#
# DESCRIPTION
#       This NAGIOS plugin checks whether: 1) maui is running and
#       2) the host is listening on the given port(s).  If no port
#       number is specified TCP ports 15001 and 42559 are checked.
#
# AUTHOR
#       Wayne.Mallett@jcu.edu.au

########### ******* Puppet Managed File ******* ###########
### This file is managed by puppet, any changes should be made on puppet
### /etc/puppet/modules/nrpe/files/cluster/check_torque.bash
############################################################################

OK=0
WARN=1
CRITICAL=2
PATH="/bin:/sbin:/usr/bin:/usr/sbin"

# Default listening ports are TCP 15001
if [ $# -lt 1 ] ; then
  list="15001"
else
  list="$*"
fi

if [ $(ps -C pbs_server | wc -l) -lt 2 ]; then
  echo "TORQUE CRITICAL:  Daemon is NOT running!"
  exit $CRITICAL
else
  for port in $list ; do
    if [ $(netstat -ln | grep -E "tcp.*:$port" | wc -l) -lt 1 ]; then
      echo "TORQUE CRITICAL:  Host is NOT listening on TCP port $port!"
      exit $CRITICAL
    fi
  done
  echo "TORQUE OK:  Daemon is running.  Host is listening."
  exit $OK
fi
