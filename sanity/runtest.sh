#!/bin/bash

. $(dirname $0)/../lib/testframeworks

./execsnoop.sh
rtr=$?
./opensnoop.sh
rtr1=$?
rtr=$(expr $rtr + $rtr1)
./ext4slower.sh
rtr1=$?
rtr=$(expr $rtr + $rtr1)
./biolatency.sh
rtr1=$?
rtr=$(expr $rtr + $rtr1)

uploadlogs

if [ $rtr -ne 0 ]; then
    exit 1
else
    exit 0
fi