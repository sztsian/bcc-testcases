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

test_ext4slower_h(){
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    ${BCCPATH}/ext4slower -h &> ${logfile}
    assertTrue "log should not be empty" "[ -s ${logfile} ]"
    assertFileContains ${logfile} usage
}

test_ext4slower(){
    createfsslow ext4 500
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    df -hT > ${logfile}
    exec ${BCCPATH}/ext4slower &>> ${logfile} &
    tpid=$!
    sleep 5
    dd if=/dev/zero of=${FSSLOWPATH}/${FUNCNAME[ 0 ]}.test count=500000
    umount ${FSSLOWPATH}
    sleep 3
    /usr/bin/kill -INT $tpid
    sleep 3
    assertTrue "log should not be empty" "[ -s ${logfile} ]"
    assertFileContains ${logfile} dd
    destroyfsslow
}

test_ext4slower_num(){
    createfsslow ext4 100
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    df -hT > ${logfile}
    exec ${BCCPATH}/ext4slower 500 &>> ${logfile} &
    tpid=$!
    sleep 5
    cp /boot/vmlinuz-$(uname -r) ${FSSLOWPATH}
    dd if=/dev/zero of=${FSSLOWPATH}/${FUNCNAME[ 0 ]}.test count=500000
    umount ${FSSLOWPATH}
    sleep 3
    /usr/bin/kill -INT $tpid
    sleep 3
    assertTrue "log should not be empty" "[ -s ${logfile} ]"
    assertFileNotContains ${logfile} dd
    destroyfsslow
}

. $(dirname $0)/../lib/include

# Tests not covered
# # ./ext4slower -j

