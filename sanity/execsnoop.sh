#!/bin/bash

bccprefix=$(rpm -ql bcc-tools | grep tools | head -n 1)
BCCPATH=${bccpath:-${bccprefix}}
LOGPREFIX=$(dirname $0)/logs/$(basename $0)

oneTimeSetUp(){
rm -rf ${LOGPREFIX}
mkdir -p ${LOGPREFIX}
ps -ef | grep '/usr/share/bcc' | grep -v grep | awk '{print $2}' | xargs /usr/bin/kill -9 {} &> /dev/null || true
}

test_execsnoop(){
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    ${BCCPATH}/execsnoop &> ${logfile} &
    tpid=$!
    sleep 3
    ls -l &>/dev/null
    /usr/bin/kill -INT $tpid
    sleep 3
    assertTrue "log should not be empty" "[ -s ${logfile} ]"
    assertFileContains ${logfile} ls
    #assertFileNotContains ${logfile} "error|Error|ERROR|Fail|FAIL|fail"
}

test_execsnoop_x(){
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    ${BCCPATH}/execsnoop -x &> ${logfile} &
    tpid=$!
    sleep 3
    /noexist -v &>/dev/null
    /usr/bin/kill -INT $tpid
    sleep 3
    assertTrue "log should not be empty" "[ -s ${logfile} ]"
    assertFileContains ${logfile} noexist
    #assertFileNotContains ${logfile} "error|Error|ERROR|Fail|FAIL|fail"
}

test_execsnoop_n(){
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    ${BCCPATH}/execsnoop -n ls &> ${logfile} &
    tpid=$!
    sleep 3
    /noexist -v &>/dev/null
    ls &>/dev/null
    /usr/bin/kill -INT $tpid
    sleep 3
    assertTrue "log should not be empty" "[ -s ${logfile} ]"
    assertFileContains ${logfile} ls
    assertFileNotContains ${logfile} sleep
    assertFileNotContains ${logfile} noexist
    #assertFileNotContains ${logfile} "error|Error|ERROR|Fail|FAIL|fail"
}

test_execsnoop_l(){
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    ${BCCPATH}/execsnoop -l testpkg &> ${logfile} &
    tpid=$!
    sleep 3
    /noexist -v &>/dev/null
    mkdir testpkg
    ls testpkg &>/dev/null
    rmdir testpkg
    touch /tmp/test
    /usr/bin/kill -INT $tpid
    sleep 3
    assertTrue "log should not be empty" "[ -s ${logfile} ]"
    assertFileContains ${logfile} mkdir
    assertFileContains ${logfile} rmdir
    assertFileContains ${logfile} ls
    assertFileNotContains ${logfile} touch
    #assertFileNotContains ${logfile} "error|Error|ERROR|Fail|FAIL|fail"
}



. $(dirname $0)/../lib/include
