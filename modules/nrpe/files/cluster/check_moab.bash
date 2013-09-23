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
### /etc/puppet/modules/nrpe/files/cluster/check_moab.bash
############################################################################

OK=0
WARN=1
CRITICAL=2
PATH="/bin:/sbin:/usr/bin:/usr/sbin"

# Default listening ports are TCP 15004 and 42559.
if [ $# -lt 1 ] ; then
  list="15004 42559"
else
  list="$*"
fi

if [ $(ps -C moab | wc -l) -lt 2 ]; then
  echo "MOAB CRITICAL:  Daemon is NOT running!"
  exit $CRITICAL
else
  for port in $list ; do
    if [ $(netstat -ln | grep -E "tcp.*:$port" | wc -l) -lt 1 ]; then
      echo "MOAB CRITICAL:  Host is NOT listening on TCP port $port!"
      exit $CRITICAL
    fi
  done
  paused=$(/usr/local/moab/latest/bin/showq | grep -c "scheduling is paused")
  if [ $paused -eq 0 ]
  then
    echo "MOAB OK:  Daemon is running.  Host is listening. Scheduler is unpaused."
    exit $OK
  else
    echo "MOAB WARNING:  Daemon is running.  Host is listening. Scheduler is paused."
    exit $WARN
  fi
fi

