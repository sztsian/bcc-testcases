#!/bin/bash

bccprefix=$(rpm -ql bcc-tools | grep tools | head -n 1)
BCCPATH=${bccpath:-${bccprefix}}
LOGPREFIX=$(dirname $0)/logs/$(basename $0)

oneTimeSetUp(){
rm -rf ${LOGPREFIX}
mkdir -p ${LOGPREFIX}
ps -ef | grep '/usr/share/bcc' | grep -v grep | awk '{print $2}' | xargs /usr/bin/kill -9 {} &> /dev/null || true
}

# Requires util-linux
test_cachestat(){
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    ${BCCPATH}/cachestat 3 3 &> ${logfile}
    rtrn=$?
    assertEquals $rtrn 0
    assertTrue "log should not be empty" "[ -s ${logfile} ]"
}

. $(dirname $0)/../lib/include
