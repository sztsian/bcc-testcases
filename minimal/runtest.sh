#!/bin/bash

bccprefix=$(rpm -ql bcc-tools | grep tools | head -n 1)
BCCPATH=${bccpath:-${bccprefix}}

oneTimeTearDown(){
    . $(dirname $0)/../lib/testframeworks
    uploadlogs
}

test_biolatency(){
    assertPass ${BCCPATH}/biolatency 1 10 &> builatency.log
}
test_biotop(){
    assertPass ${BCCPATH}/biotop -C 5 5 &> biotop.log
}
test_cachestat(){
    assertPass ${BCCPATH}/cachestat 1 3 | tail -n 1 &> cachestat.log
}
test_hardirqs(){
    assertPass ${BCCPATH}/hardirqs 1 10 &> hardirqs.log
}
test_profile(){
    assertPass ${BCCPATH}/profile 5 -a &> profile.log
}
test_reset-trace(){
    assertPass ${BCCPATH}/reset-trace -vF 2>&1 | grep debug &> reset-trace.log
}
test_runqlat(){
    assertPass ${BCCPATH}/runqlat 1 10 2>&1 | grep '>' &> runqlat.log
}
test_runqlen(){
    assertPass ${BCCPATH}/runqlen 1 10 &> runqlen.log
}
test_slabratetop(){
    assertPass ${BCCPATH}/slabratetop -C 5 3 &> slabratetop.log
}
test_softirqs(){
    assertPass ${BCCPATH}/softirqs 1 5 &> softirqs.log
}
test_syscount(){
    assertPass ${BCCPATH}/syscount -d 5 &> syscount.log
}
test_tplist(){
    assertPass ${BCCPATH}/tplist &> tplist.log
}
test_wakeuptime(){
    assertPass ${BCCPATH}/wakeuptime 5 &> wakeuptime.log
}
test_deadlock(){
    skipIfNotExist ${BCCPATH}/$(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
    assertPassTerm ${BCCPATH}/deadlock --binary /usr/lib64/libpthread.so.0 $(pidof auditd)  &> deadlock.log
    assertPassOrKeyboardInt $? deadlock.log $(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
}
test_klockstat(){
    skipIfNotExist ${BCCPATH}/$(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
    assertPass ${BCCPATH}/klockstat -d 5 &> klockstat.log
}
test_vfsstat(){
    skipIfNotExist ${BCCPATH}/$(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
    assertPass ${BCCPATH}/vfsstat 5 2 &> vfsstat.log
}

. $(dirname $0)/../lib/include
