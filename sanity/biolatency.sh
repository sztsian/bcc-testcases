#!/bin/bash

bccprefix=$(rpm -ql bcc-tools | grep tools | head -n 1)
BCCPATH=${bccpath:-${bccprefix}}
LOGPREFIX=$(dirname $0)/logs/$(basename $0)

. $(dirname $0)/../lib/createfs

oneTimeSetUp(){
rm -rf ${LOGPREFIX}
mkdir -p ${LOGPREFIX}
ps -ef | grep '/usr/share/bcc' | grep -v grep | awk '{print $2}' | xargs /usr/bin/kill -9 {} &> /dev/null || true
}

test_biolatency_mT(){
    createfsslow ext4 500
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    df -hT > ${logfile}
    exec ${BCCPATH}/biolatency -mT 2 5 &>> ${logfile} &
    tpid=$!
    sleep 3
    dd if=/dev/zero of=${FSSLOWPATH}/${FUNCNAME[ 0 ]}.test count=500000
    rm -f ${FSSLOWPATH}/${FUNCNAME[ 0 ]}.test
    sleep 13
    assertFileContains ${logfile} msecs
    assertFileContains ${logfile} '|'
    destroyfsslow
}

test_biolatency_D(){
    createfsslow ext4 500
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    df -hT > ${logfile}
    exec ${BCCPATH}/biolatency -D &>> ${logfile} &
    tpid=$!
    sleep 3
    dd if=/dev/zero of=${FSSLOWPATH}/${FUNCNAME[ 0 ]}.test count=500000
    rm -f ${FSSLOWPATH}/${FUNCNAME[ 0 ]}.test
    sleep 3
    /usr/bin/kill -INT $tpid
    sleep 3
    assertFileContains ${logfile} disk
    destroyfsslow
}

test_biolatency_F(){
${BCCPATH}/biolatency -h | grep '\-F'
if [ $? -eq 0 ] ; then
    createfsslow ext4 500
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    df -hT > ${logfile}
    exec ${BCCPATH}/biolatency -Fm &>> ${logfile} &
    tpid=$!
    sleep 3
    dd if=/dev/zero of=${FSSLOWPATH}/${FUNCNAME[ 0 ]}.test count=500000
    rm -f ${FSSLOWPATH}/${FUNCNAME[ 0 ]}.test
    sleep 3
    /usr/bin/kill -INT $tpid
    sleep 3
    assertFileContains ${logfile} flags
    destroyfsslow
else
    startSkipping
    endSkipping
fi
}


. $(dirname $0)/../lib/include

# Tests not covered
# # ./biolatency
# # ./biolatency -Q

