#!/bin/bash

bccprefix=$(rpm -ql bcc-tools | grep tools | head -n 1)
BCCPATH=${bccpath:-${bccprefix}}
LOGPREFIX=$(dirname $0)/logs/$(basename $0)

oneTimeSetUp(){
rm -rf ${LOGPREFIX}
mkdir -p ${LOGPREFIX}
ps -ef | grep '/usr/share/bcc' | grep -v grep | awk '{print $2}' | xargs /usr/bin/kill -9 {} &> /dev/null || true
}

test_opensnoop_h(){
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    ${BCCPATH}/opensnoop -h &> ${logfile}
    assertFileContains ${logfile} usage
}


test_opensnoop(){
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    exec ${BCCPATH}/opensnoop &> ${logfile} &
    tpid=$!
    sleep 3
    systemctl status dbus &>/dev/null
    sleep 2
    /usr/bin/kill -INT $tpid
    sleep 3
    assertFileContains ${logfile} dbus
    #assertFileNotContains ${logfile} "error|Error|ERROR|Fail|FAIL|fail"
}

test_opensnoop_p(){
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    exec ${BCCPATH}/biotop &
    topid=$!
    exec ${BCCPATH}/opensnoop -Tp ${topid} &> ${logfile} &
    tpid=$!
    sleep 3
    systemctl status dbus &>/dev/null
    /usr/bin/kill -INT $tpid
    /usr/bin/kill -9 $topid
    sleep 3
    assertFileContains ${logfile} biotop
    assertFileNotContains ${logfile} dbus
    #assertFileNotContains ${logfile} "error|Error|ERROR|Fail|FAIL|fail"
}

# In this test, you should have a user 'tests'
test_opensnoop_u(){
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    exec ${BCCPATH}/opensnoop -Uu $(id -u tests) &> ${logfile} &
    tpid=$!
    sleep 3
    su - tests -c "systemctl status dbus &>/dev/null"
    systemctl status dbus &>/dev/null
    /usr/bin/kill -INT $tpid
    sleep 3
    assertFileContains ${logfile} 'UID'
    assertFileContains ${logfile} $(id -u tests)
    assertFileNotContains ${logfile} "^0"
}

test_opensnoop_x(){
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    exec ${BCCPATH}/opensnoop -x &> ${logfile} &
    tpid=$!
    sleep 3
    df
    sleep 2
    /usr/bin/kill -INT $tpid
    sleep 3
    assertFileContains ${logfile} 'df'
}

test_opensnoop_d(){
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    ${BCCPATH}/opensnoop -d 2 &> ${logfile}
    sleep 5
    assertFileContains ${logfile} PID
}

test_opensnoop_n(){
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    exec ${BCCPATH}/opensnoop -n ed &> ${logfile} &
    tpid=$!
    sleep 2
    cp /etc/passwd /tmp/passwd
    sed 's/root/toor/g' /tmp/passwd &>/dev/null
    rm /tmp/passwd
    /usr/bin/kill -INT $tpid
    sleep 3
    assertFileContains ${logfile} sed
}

test_opensnoop_e(){
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    ${BCCPATH}/opensnoop -e &> ${logfile} &
    tpid=$!
    sleep 3
    df
    sleep 2
    /usr/bin/kill -INT $tpid
    sleep 3
    assertFileContains ${logfile} 'df'
    assertFileContains ${logfile} FLAGS
}





. $(dirname $0)/../lib/include

# Tests not covered
# # ./opensnoop -e -f O_WRONLY -f O_RDWR

