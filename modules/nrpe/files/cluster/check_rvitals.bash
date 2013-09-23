#!/bin/bash

########### ******* Puppet Managed File ******* ###########
### This file is managed by puppet, any changes should be made on puppet
### /etc/puppet/modules/nrpe/files/cluster/check_rvitals.bash
############################################################################

# Setup standard Nagios/NRPE return codes
#
UNKNOWN_STATE=3
CRITICAL_STATE=2
WARNING_STATE=1
OK_STATE=0

bad=$(sudo /opt/xcat/bin/rvitals login,compute leds 2>&1| grep -v "No active error LEDs detected" | awk -F: '{print $1}' | sort | uniq)
count=$(echo $bad | wc -w)

if [ $count -eq 0 ]
then
        echo "OK - No rvitals problems"
        exit ${OK_STATE}
elif [ $count -eq 1 ]
then
        echo "CRITICAL - LED set on node $bad"
        exit ${CRITICAL_STATE}
else
        badnode=$(echo $bad | sed 's/\n/ /')
        echo "CRITICAL - LED set on nodes $badnode"
        exit ${CRITICAL_STATE}
fi

