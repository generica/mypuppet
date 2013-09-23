#!/bin/bash

########### ******* Puppet Managed File ******* ###########
### This file is managed by puppet, any changes should be made on puppet
### /etc/puppet/modules/nrpe/files/cluster/check_usr_local_src.bash
############################################################################

# Setup standard Nagios/NRPE return codes
#
UNKNOWN_STATE=3
CRITICAL_STATE=2
WARNING_STATE=1
OK_STATE=0

mountpoint -q /vlsci
if [ $? -ne 0 ]
then
        echo "CRITICAL - /vlsci filesystem not mounted"
        exit ${CRITICAL_STATE}
fi

mode=$(/usr/bin/stat -c '%a' /usr/local/src/ | tail -c2)

if [ $mode -gt 0 ]
then
        echo "CRITICAL - /usr/local/src is world readable"
        exit ${CRITICAL_STATE}
elif [ $mode -eq 0 ]
then
        echo "OK - /usr/local/src is not world readable"
        exit ${OK_STATE}
else
        echo "Unable to determine /usr/local/src status."
        exit ${UNKNOWN_STATE}
fi

echo "Unable to determine /usr/local/src status."
exit ${UNKNOWN_STATE}

