#!/bin/bash -i

bccprefix=$(rpm -ql bcc-tools | grep tools | head -n 1)
BCCPATH=${bccpath:-${bccprefix}}
LOGPREFIX=$(dirname $0)/logs/$(basename $0)

oneTimeSetUp(){
rm -rf ${LOGPREFIX}
mkdir -p ${LOGPREFIX}
ps -ef | grep '/usr/share/bcc' | grep -v grep | awk '{print $2}' | xargs /usr/bin/kill -9 {} &> /dev/null || true 
}

oneTimeTearDown(){
    . $(dirname $0)/../lib/testframeworks
    uploadlogs
}

test_biolatency(){
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    assertPass ${BCCPATH}/biolatency 1 2 &> ${logfile}
}

test_biolatency_Q(){
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    assertPass ${BCCPATH}/biolatency -Q 1 2 &> ${logfile}
}

test_biosnoop(){
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    assertPassInt ${BCCPATH}/biosnoop &> ${logfile}
}

test_biotop(){
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    assertPass ${BCCPATH}/biotop 2 2 &> ${logfile}
}

test_bitesize(){
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    assertPassInt ${BCCPATH}/bitesize &> ${logfile}
}

test_cachestat(){
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    assertPass ${BCCPATH}/cachestat 2 2 &> ${logfile}
}

test_cachetop(){
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    assertPassIntCurses ${BCCPATH}/cachetop &> ${logfile}
}

test_cpudist(){
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    assertPass ${BCCPATH}/cpudist 2 2 &> ${logfile}
}

test_dcsnoop(){
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    assertPassTerm ${BCCPATH}/dcsnoop &> ${logfile}
}

test_dcsnoop_a(){
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    assertPassTerm ${BCCPATH}/dcsnoop -a &> ${logfile}
}

test_dcstat(){
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    assertPass ${BCCPATH}/dcstat 2 2 &> ${logfile}
}

test_execsnoop(){
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    assertPassTerm ${BCCPATH}/execsnoop &> ${logfile}
}

test_ext4dist(){
    modprobe ext4
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    assertPass ${BCCPATH}/ext4dist 2 2 &> ${logfile}
}

test_ext4slower(){
    modprobe ext4
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    assertPassInt ${BCCPATH}/ext4slower &> ${logfile}
}

test_filelife(){
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    assertPassInt ${BCCPATH}/filelife &> ${logfile}
}

test_fileslower(){
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    assertPassInt ${BCCPATH}/fileslower &> ${logfile}
}

test_filetop(){
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    assertPass ${BCCPATH}/filetop 2 2 &> ${logfile}
}

test_hardirqs(){
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    assertPass ${BCCPATH}/hardirqs 2 2 &> ${logfile}
}

test_killsnoop(){
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    assertPassTerm ${BCCPATH}/killsnoop &> ${logfile}
}

test_mdflush(){
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    assertPassInt ${BCCPATH}/mdflush &> ${logfile}
}

test_mountsnoop(){
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    assertPassInt ${BCCPATH}/mountsnoop &> ${logfile}
}

test_nfsdist(){
    modprobe nfs
    modprobe nfsv4
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    assertPass ${BCCPATH}/nfsdist 2 2 &> ${logfile}
}

test_nfsslower(){
    modprobe nfs
    modprobe nfsv4
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    assertPassInt ${BCCPATH}/nfsslower &> ${logfile}
}

test_offcputime(){
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    assertPass ${BCCPATH}/offcputime 2 &> ${logfile}
}

test_offwaketime(){
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    assertPass ${BCCPATH}/offwaketime 2 &> ${logfile}
}

test_oomkill(){
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    assertPassInt ${BCCPATH}/oomkill &> ${logfile}
}

test_opensnoop(){
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    assertPass ${BCCPATH}/opensnoop -d 2 &> ${logfile}
}

test_pidpersec(){
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    assertPassInt ${BCCPATH}/pidpersec &> ${logfile}
}

test_runqlat(){
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    assertPass ${BCCPATH}/runqlat 2 2 &> ${logfile}
}

test_runqslower(){
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    assertPassInt ${BCCPATH}/runqslower &> ${logfile}
}

test_slabratetop(){
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    assertPass ${BCCPATH}/slabratetop 2 2 &> ${logfile}
}

test_sofdsnoop(){
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    assertPass ${BCCPATH}/sofdsnoop -d 2 &> ${logfile}
}

test_solisten(){
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    assertPassInt15 ${BCCPATH}/solisten &> ${logfile}
}

test_syncsnoop(){
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    assertPassInt ${BCCPATH}/syncsnoop &> ${logfile}
}

test_tcpconnect(){
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    assertPassInt15 ${BCCPATH}/tcpconnect &> ${logfile}
}

test_tcpconnlat(){
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    assertPassInt15 ${BCCPATH}/tcpconnlat &> ${logfile}
}

test_tcplife(){
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    assertPassInt15 ${BCCPATH}/tcplife &> ${logfile}
}

test_tcpretrans_l(){
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    assertPassInt15 ${BCCPATH}/tcpretrans -l &> ${logfile}
}

test_tcpsubnet(){
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    assertPassInt15 ${BCCPATH}/tcpsubnet &> ${logfile}
}

test_tcptop(){
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    assertPass ${BCCPATH}/tcptop 2 2 &> ${logfile}
}

# tcptracer requires a very loooooong time to init
# so do not use assertPassInt
test_tcptracer(){
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    assertPassInt15 ${BCCPATH}/tcptracer &> ${logfile} &
}

test_ttysnoop(){
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    assertPassInt ${BCCPATH}/ttysnoop /dev/tty0 &> ${logfile}
}

test_vfsstat(){
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    assertPass ${BCCPATH}/vfsstat 2 2 &> ${logfile}
}

test_wakeuptime(){
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    assertPass ${BCCPATH}/wakeuptime 4 &> ${logfile}
}

test_xfsdist(){
    modprobe xfs
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    assertPass ${BCCPATH}/xfsdist 2 2 &> ${logfile}
}

test_xfsslower(){
    modprobe xfs
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    assertPassInt ${BCCPATH}/xfsslower &> ${logfile}
}

. $(dirname $0)/../lib/include
