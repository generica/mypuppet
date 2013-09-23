#!/bin/bash

########### ******* Puppet Managed File ******* ###########
### This file is managed by puppet, any changes should be made on puppet
### /etc/puppet/modules/nrpe/files/cluster/check_phi.bash
############################################################################

# Setup standard Nagios/NRPE return codes
#
UNKNOWN_STATE=3
CRITICAL_STATE=2
WARNING_STATE=1
OK_STATE=0

bad=$(sudo /opt/xcat/bin/nodestat mic 2>&1| egrep -v ": sshd$" | awk -F: '{print $1}' | sort | uniq)
count=$(echo $bad | wc -w)

if [ $count -eq 0 ]
then
        echo "OK - All phi cards booted"
        exit ${OK_STATE}
elif [ $count -eq 1 ]
then
        echo "CRITICAL - Phi ndoe $bad not booted"
        exit ${CRITICAL_STATE}
else
        badnode=$(echo $bad | sed 's/\n/ /')
        echo "CRITICAL - Phi nodes $badnode not booted"
        exit ${CRITICAL_STATE}
fi

