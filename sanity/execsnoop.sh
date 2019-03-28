#!/bin/bash

bccprefix=$(rpm -ql bcc-tools | grep tools | head -n 1)
BCCPATH=${bccpath:-${bccprefix}}
LOGPREFIX=$(dirname $0)/logs/$(basename $0)

oneTimeSetUp(){
rm -rf ${LOGPREFIX}
mkdir -p ${LOGPREFIX}
}

assertPass(){
    $@
    assertEquals '$@ failed' 0 $?
}

# assertFileContains
# Param1: Filename
# Param2: pattern
assertFileContains(){
    egrep $2 $1 | grep -v 'grep' &>/dev/null
    assertEquals 'Missing content in file' 0 $?
}
assertFileNotContains(){
    egrep $2 $1 | grep -v 'grep' &>/dev/null
    assertEquals 'File should not contain the keyword' 1 $?
}

test_execsnoop(){
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    ${BCCPATH}/execsnoop &> ${logfile} &
    tpid=$!
    sleep 3
    ls -l &>/dev/null
    kill -INT $tpid
    sleep 3
    assertFileContains ${logfile} ls
    #assertFileNotContains ${logfile} "error|Error|ERROR|Fail|FAIL|fail"
}

test_execsnoop_x(){
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    ${BCCPATH}/execsnoop -x &> ${logfile} &
    tpid=$!
    sleep 3
    /noexist -v &>/dev/null
    kill -INT $tpid
    sleep 3
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
    kill -INT $tpid
    sleep 3
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
    kill -INT $tpid
    sleep 3
    assertFileContains ${logfile} mkdir
    assertFileContains ${logfile} rmdir
    assertFileContains ${logfile} ls
    assertFileNotContains ${logfile} touch
    #assertFileNotContains ${logfile} "error|Error|ERROR|Fail|FAIL|fail"
}



. $(dirname $0)/../shunit2
