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
    skipIfNotExist ${BCCPATH}/$(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    assertPass ${BCCPATH}/biolatency 1 2 &> ${logfile}
}

test_biolatency_Q(){
    skipIfNotExist ${BCCPATH}/$(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    assertPass ${BCCPATH}/biolatency -Q 1 2 &> ${logfile}
}

test_biosnoop(){
    skipIfNotExist ${BCCPATH}/$(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    assertPassInt ${BCCPATH}/biosnoop &> ${logfile}
}

test_biotop(){
    skipIfNotExist ${BCCPATH}/$(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    assertPass ${BCCPATH}/biotop 2 2 &> ${logfile}
}

test_bitesize(){
    skipIfNotExist ${BCCPATH}/$(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    assertPassInt ${BCCPATH}/bitesize &> ${logfile}
}

test_cachestat(){
    skipIfNotExist ${BCCPATH}/$(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    assertPass ${BCCPATH}/cachestat 2 2 &> ${logfile}
}

test_cachetop(){
    skipIfNotExist ${BCCPATH}/$(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    assertPassIntCurses ${BCCPATH}/cachetop &> ${logfile}
}

test_cpudist(){
    skipIfNotExist ${BCCPATH}/$(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    assertPass ${BCCPATH}/cpudist 2 2 &> ${logfile}
}

test_dcsnoop(){
    skipIfNotExist ${BCCPATH}/$(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    assertPassTerm ${BCCPATH}/dcsnoop &> ${logfile}
}

test_dcsnoop_a(){
    skipIfNotExist ${BCCPATH}/$(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    assertPassTerm ${BCCPATH}/dcsnoop -a &> ${logfile}
}

test_dcstat(){
    skipIfNotExist ${BCCPATH}/$(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    assertPass ${BCCPATH}/dcstat 2 2 &> ${logfile}
}

test_execsnoop(){
    skipIfNotExist ${BCCPATH}/$(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    assertPassTerm ${BCCPATH}/execsnoop &> ${logfile}
}

test_ext4dist(){
    skipIfNotExist ${BCCPATH}/$(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
    modprobe ext4
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    assertPass ${BCCPATH}/ext4dist 2 2 &> ${logfile}
}

test_ext4slower(){
    skipIfNotExist ${BCCPATH}/$(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
    modprobe ext4
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    assertPassInt ${BCCPATH}/ext4slower &> ${logfile}
}

test_filelife(){
    skipIfNotExist ${BCCPATH}/$(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    assertPassInt ${BCCPATH}/filelife &> ${logfile}
}

test_fileslower(){
    skipIfNotExist ${BCCPATH}/$(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    assertPassInt ${BCCPATH}/fileslower &> ${logfile}
}

test_filetop(){
    skipIfNotExist ${BCCPATH}/$(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    assertPass ${BCCPATH}/filetop 2 2 &> ${logfile}
}

test_hardirqs(){
    skipIfNotExist ${BCCPATH}/$(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    assertPass ${BCCPATH}/hardirqs 2 2 &> ${logfile}
}

test_killsnoop(){
    skipIfNotExist ${BCCPATH}/$(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    assertPassTerm ${BCCPATH}/killsnoop &> ${logfile}
}

test_mdflush(){
    skipIfNotExist ${BCCPATH}/$(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    assertPassInt ${BCCPATH}/mdflush &> ${logfile}
}

test_mountsnoop(){
    skipIfNotExist ${BCCPATH}/$(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    assertPassInt ${BCCPATH}/mountsnoop &> ${logfile}
}

test_nfsdist(){
    skipIfNotExist ${BCCPATH}/$(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
    modprobe nfs
    modprobe nfsv4
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    assertPass ${BCCPATH}/nfsdist 2 2 &> ${logfile}
}

test_nfsslower(){
    skipIfNotExist ${BCCPATH}/$(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
    modprobe nfs
    modprobe nfsv4
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    assertPassInt ${BCCPATH}/nfsslower &> ${logfile}
}

test_offcputime(){
    skipIfNotExist ${BCCPATH}/$(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    assertPass ${BCCPATH}/offcputime 2 &> ${logfile}
}

test_offwaketime(){
    skipIfNotExist ${BCCPATH}/$(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    assertPass ${BCCPATH}/offwaketime 2 &> ${logfile}
}

test_oomkill(){
    skipIfNotExist ${BCCPATH}/$(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    assertPassInt ${BCCPATH}/oomkill &> ${logfile}
}

test_opensnoop(){
    skipIfNotExist ${BCCPATH}/$(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    assertPass ${BCCPATH}/opensnoop -d 2 &> ${logfile}
}

test_pidpersec(){
    skipIfNotExist ${BCCPATH}/$(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    assertPassInt ${BCCPATH}/pidpersec &> ${logfile}
}

test_runqlat(){
    skipIfNotExist ${BCCPATH}/$(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    assertPass ${BCCPATH}/runqlat 2 2 &> ${logfile}
}

test_runqslower(){
    skipIfNotExist ${BCCPATH}/$(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    assertPassInt ${BCCPATH}/runqslower &> ${logfile}
}

test_slabratetop(){
    skipIfNotExist ${BCCPATH}/$(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    assertPass ${BCCPATH}/slabratetop 2 2 &> ${logfile}
}

test_sofdsnoop(){
    skipIfNotExist ${BCCPATH}/$(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    assertPass ${BCCPATH}/sofdsnoop -d 2 &> ${logfile}
}

test_solisten(){
    skipIfNotExist ${BCCPATH}/$(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    assertPassInt15 ${BCCPATH}/solisten &> ${logfile}
}

test_syncsnoop(){
    skipIfNotExist ${BCCPATH}/$(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    assertPassInt ${BCCPATH}/syncsnoop &> ${logfile}
}

test_tcpconnect(){
    skipIfNotExist ${BCCPATH}/$(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    assertPassInt15 ${BCCPATH}/tcpconnect &> ${logfile}
}

test_tcpconnlat(){
    skipIfNotExist ${BCCPATH}/$(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    assertPassInt15 ${BCCPATH}/tcpconnlat &> ${logfile}
}

test_tcplife(){
    skipIfNotExist ${BCCPATH}/$(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    assertPassInt15 ${BCCPATH}/tcplife &> ${logfile}
}

test_tcpretrans_l(){
    skipIfNotExist ${BCCPATH}/$(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    assertPassInt15 ${BCCPATH}/tcpretrans -l &> ${logfile}
}

test_tcpsubnet(){
    skipIfNotExist ${BCCPATH}/$(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    assertPassInt15 ${BCCPATH}/tcpsubnet &> ${logfile}
}

test_tcptop(){
    skipIfNotExist ${BCCPATH}/$(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    assertPass ${BCCPATH}/tcptop 2 2 &> ${logfile}
}

test_tcptracer(){
    skipIfNotExist ${BCCPATH}/$(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    assertPassInt15 ${BCCPATH}/tcptracer &> ${logfile} &
}

test_ttysnoop(){
    skipIfNotExist ${BCCPATH}/$(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    assertPassInt ${BCCPATH}/ttysnoop /dev/tty0 &> ${logfile}
}

test_vfsstat(){
    skipIfNotExist ${BCCPATH}/$(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    assertPass ${BCCPATH}/vfsstat 2 2 &> ${logfile}
}

test_wakeuptime(){
    skipIfNotExist ${BCCPATH}/$(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    assertPass ${BCCPATH}/wakeuptime 4 &> ${logfile}
}

test_xfsdist(){
    skipIfNotExist ${BCCPATH}/$(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
    modprobe xfs
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    assertPass ${BCCPATH}/xfsdist 2 2 &> ${logfile}
}

test_xfsslower(){
    skipIfNotExist ${BCCPATH}/$(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
    modprobe xfs
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    assertPassInt ${BCCPATH}/xfsslower &> ${logfile}
}

. $(dirname $0)/../lib/include
