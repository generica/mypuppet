#!/bin/bash

OK=0
WARN=1
CRITICAL=2
PATH="/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/slurm/latest/bin"

if [ $(ps -C slurmctld | wc -l) -lt 2 ]
then
  echo "SLURM CRITICAL:  Control daemon is NOT running!"
  exit $CRITICAL
fi

# Query SLURM to find out what port the control daemon should be listening on
port=`scontrol show config | grep SlurmctldPort | awk '{print $3}'`

if [ $(netstat -ln | grep -E "tcp.*:$port" | wc -l) -lt 1 ]
then
  echo "SLURM CRITICAL:  Host is NOT listening on TCP port $port!"
  exit $CRITICAL
fi

# Exit here.
# On x86 we don't have any Frontend nodes

echo "SLURM OK:  Control daemon is running."
exit $OK

num_fens=`scontrol show frontend | grep FrontendName | wc -l`
if [ $(scontrol show frontend | grep State=DOWN | wc -l) -eq $num_fens ]
then
  echo "SLURM CRITICAL:  All frontend nodes are DOWN!"
  exit $CRITICAL
fi

# Loop through all our launch nodes and make sure they're up
for fen in `scontrol show frontend | grep FrontendName | awk '{print $1}' | awk -F'=' '{print $2}'`
do
  # skip avoca frontend node - it's normally down
  if [ "$fen" = "avoca" ]
  then
    continue
  fi
  if [ $(scontrol show frontend $fen | grep DOWN | wc -l) -ne 0 ]
  then
    reason=`scontrol show frontend $fen | grep DOWN | awk -F'=' '{print $4}'`
    echo "SLURM WARNING:  Frontend $fen is DOWN with reason: $reason"
    exit $WARN
  fi
  if [ $(scontrol show frontend $fen | grep DRAIN | wc -l) -ne 0 ]
  then
    reason=`scontrol show frontend $fen | grep DRAIN | awk -F'=' '{print $4}'`
    echo "SLURM WARNING:  Frontend $fen is DRAIN with reason: $reason"
    exit $WARN
  fi
done

# Loop through all our partitions and make sure that they're all up
for part in `scontrol show part | grep PartitionName | awk '{print $1}' | awk -F'=' '{print $2}'`
do
  part_state=`scontrol show part $part -o | awk '{print $19}'`
  if [ "$part_state" != "State=UP" ]
  then
    echo "SLURM WARNING:  Partition $part is NOT UP, currently $part_state"
    exit $WARN
  fi
done

echo "SLURM OK:  Control daemon is running.  Frontend nodes are up."
exit $OK

