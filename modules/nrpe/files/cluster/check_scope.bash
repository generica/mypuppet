#!/bin/bash

########### ******* Puppet Managed File ******* ###########
### This file is managed by puppet, any changes should be made on puppet
### /etc/puppet/modules/nrpe/files/cluster/check_scope.bash
############################################################################


# Check for lifescope/bioscope on Bruce/Merri

lifescope_pid=$(ps ax | grep -v grep | grep 'com.lifetechnologies.bioscope.webservice.WebServer' | awk '{print $1}')
bioscope_pid=$(ps ax | grep -v grep | grep '/bioscope/1.3.1/apache-activemq-5.3.0/bin/run.jar' | awk '{print $1}')

if [ "x$lifescope_pid$bioscope_pid" == "x" ]
then
        echo "CRITICAL - {Bio,Life}scope not running"
        exit 2
elif [ "x$lifescope_pid" == "x" ]
then
        echo "OK - Bioscope running with PID $bioscope_pid"
        exit 0
else
        echo "OK - Lifescope running with PID $lifescope_pid"
        exit 0
fi

