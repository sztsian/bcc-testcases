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
    assertTrue "log should not be empty" "[ -s ${logfile} ]"
    assertFileContains ${logfile} usage
}


test_opensnoop(){
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    exec ${BCCPATH}/opensnoop &> ${logfile} &
    tpid=$!
    sleep 5
    systemctl status dbus &>/dev/null
    sleep 2
    /usr/bin/kill -TERM $tpid
    wait $tpid
    assertTrue "log should not be empty" "[ -s ${logfile} ]"
    assertFileContains ${logfile} dbus
    #assertFileNotContains ${logfile} "error|Error|ERROR|Fail|FAIL|fail"
}

test_opensnoop_p(){
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    exec ${BCCPATH}/biotop &
    topid=$!
    exec unbuffer ${BCCPATH}/opensnoop -Tp ${topid} &> ${logfile} &
    tpid=$!
    sleep 5
    systemctl status dbus &>/dev/null
    /usr/bin/kill -TERM $tpid
    /usr/bin/kill -9 $topid
    wait $tpid
    assertTrue "log should not be empty" "[ -s ${logfile} ]"
    assertFileContains ${logfile} biotop
    assertFileNotContains ${logfile} dbus
    #assertFileNotContains ${logfile} "error|Error|ERROR|Fail|FAIL|fail"
}

# In this test, you should have a user 'test'
test_opensnoop_u(){
if id test &>/dev/null ; then
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    exec ${BCCPATH}/opensnoop -Uu $(id -u test) &> ${logfile} &
    tpid=$!
    sleep 5
    su - test -c "systemctl status dbus &>/dev/null"
    systemctl status dbus &>/dev/null
    /usr/bin/kill -TERM $tpid
    wait $tpid
    assertTrue "log should not be empty" "[ -s ${logfile} ]"
    assertFileContains ${logfile} 'UID'
    assertFileContains ${logfile} $(id -u test)
    assertFileNotContains ${logfile} "^0"
else
	startSkipping
	endSkipping
fi
}

test_opensnoop_x(){
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    exec ${BCCPATH}/opensnoop -x &> ${logfile} &
    tpid=$!
    sleep 5
    df
    sleep 2
    /usr/bin/kill -TERM $tpid
    wait $tpid
    assertTrue "log should not be empty" "[ -s ${logfile} ]"
    assertFileContains ${logfile} 'df'
}

test_opensnoop_d(){
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    ${BCCPATH}/opensnoop -d 2 &> ${logfile}
    tpid=$!
    sleep 5
    wait $tpid
    assertTrue "log should not be empty" "[ -s ${logfile} ]"
    assertFileContains ${logfile} PID
}

test_opensnoop_n(){
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    exec ${BCCPATH}/opensnoop -n ed &> ${logfile} &
    tpid=$!
    sleep 5
    cp /etc/passwd /tmp/passwd
    sed 's/root/toor/g' /tmp/passwd &>/dev/null
    rm /tmp/passwd
    /usr/bin/kill -TERM $tpid
    wait $tpid
    assertTrue "log should not be empty" "[ -s ${logfile} ]"
    assertFileContains ${logfile} sed
}

test_opensnoop_e(){
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    ${BCCPATH}/opensnoop -e &> ${logfile} &
    tpid=$!
    sleep 5
    df
    sleep 2
    /usr/bin/kill -TERM $tpid
    wait $tpid
    assertTrue "log should not be empty" "[ -s ${logfile} ]"
    assertFileContains ${logfile} 'df'
    assertFileContains ${logfile} FLAGS
}





. $(dirname $0)/../lib/include

# Tests not covered
# # ./opensnoop -e -f O_WRONLY -f O_RDWR

