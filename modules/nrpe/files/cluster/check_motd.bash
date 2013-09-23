#!/bin/bash

########### ******* Puppet Managed File ******* ###########
### This file is managed by puppet, any changes should be made on puppet
### /etc/puppet/modules/nrpe/files/cluster/check_motd.bash
############################################################################

# Compare MOTD to vanilla
UNKNOWN_STATE=3
CRITICAL_STATE=2
WARNING_STATE=1
OK_STATE=0

if [ ! -f /etc/motd.vanilla ]
then
        echo "UNKNOWN - No vanilla motd for comparison"
        exit $UNKNOWN_STATE
fi

cmp -s /etc/motd.vanilla /etc/motd
result=$?

if [ $result -eq 0 ]
then
        echo "OK - MOTD is vanilla"
        exit $OK_STATE
else
        echo "CRITICAL - MOTD is not vanilla"
        exit $CRITICAL_STATE
fi
