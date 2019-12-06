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
    ${BCCPATH}/biolatency 1 2 &> ${logfile}
    assertPassOrKeyboardInt $? ${logfile} $(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
}

test_biolatency_Q(){
    skipIfNotExist ${BCCPATH}/$(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    ${BCCPATH}/biolatency -Q 1 2 &> ${logfile}
    assertPassOrKeyboardInt $? ${logfile} $(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
}

test_biosnoop(){
    skipIfNotExist ${BCCPATH}/$(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    assertPassInt ${BCCPATH}/biosnoop &> ${logfile}
    assertPassOrKeyboardInt $? ${logfile} $(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
}

test_biotop(){
    skipIfNotExist ${BCCPATH}/$(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    ${BCCPATH}/biotop 2 2 &> ${logfile}
    assertPassOrKeyboardInt $? ${logfile} $(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
}

test_bitesize(){
    skipIfNotExist ${BCCPATH}/$(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    assertPassInt ${BCCPATH}/bitesize &> ${logfile}
    assertPassOrKeyboardInt $? ${logfile} $(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
}

test_cachestat(){
    skipIfNotExist ${BCCPATH}/$(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    ${BCCPATH}/cachestat 2 2 &> ${logfile}
    assertPassOrKeyboardInt $? ${logfile} $(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
}

test_cachetop(){
    skipIfNotExist ${BCCPATH}/$(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    assertPassIntCurses ${BCCPATH}/cachetop &> ${logfile}
    assertPassOrKeyboardInt $? ${logfile} $(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
}

test_cpudist(){
    skipIfNotExist ${BCCPATH}/$(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    ${BCCPATH}/cpudist 2 2 &> ${logfile}
    assertPassOrKeyboardInt $? ${logfile} $(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
}

test_dcsnoop(){
    skipIfNotExist ${BCCPATH}/$(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    assertPassTerm ${BCCPATH}/dcsnoop &> ${logfile}
    assertPassOrKeyboardInt $? ${logfile} $(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
}

test_dcsnoop_a(){
    skipIfNotExist ${BCCPATH}/$(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    assertPassTerm ${BCCPATH}/dcsnoop -a &> ${logfile}
    assertPassOrKeyboardInt $? ${logfile} $(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
}

test_dcstat(){
    skipIfNotExist ${BCCPATH}/$(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    ${BCCPATH}/dcstat 2 2 &> ${logfile}
    assertPassOrKeyboardInt $? ${logfile} $(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
}

test_execsnoop(){
    skipIfNotExist ${BCCPATH}/$(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    assertPassTerm ${BCCPATH}/execsnoop &> ${logfile}
    assertPassOrKeyboardInt $? ${logfile} $(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
}

test_ext4dist(){
    skipIfNotExist ${BCCPATH}/$(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
    modprobe ext4
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    ${BCCPATH}/ext4dist 2 2 &> ${logfile}
    assertPassOrKeyboardInt $? ${logfile} $(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
}

test_ext4slower(){
    skipIfNotExist ${BCCPATH}/$(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
    modprobe ext4
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    assertPassInt ${BCCPATH}/ext4slower &> ${logfile}
    assertPassOrKeyboardInt $? ${logfile} $(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
}

test_filelife(){
    skipIfNotExist ${BCCPATH}/$(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    assertPassInt ${BCCPATH}/filelife &> ${logfile}
    assertPassOrKeyboardInt $? ${logfile} $(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
}

test_fileslower(){
    skipIfNotExist ${BCCPATH}/$(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    assertPassInt ${BCCPATH}/fileslower &> ${logfile}
    assertPassOrKeyboardInt $? ${logfile} $(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
}

test_filetop(){
    skipIfNotExist ${BCCPATH}/$(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    ${BCCPATH}/filetop 2 2 &> ${logfile}
    assertPassOrKeyboardInt $? ${logfile} $(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
}

test_hardirqs(){
    skipIfNotExist ${BCCPATH}/$(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    ${BCCPATH}/hardirqs 2 2 &> ${logfile}
    assertPassOrKeyboardInt $? ${logfile} $(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
}

test_killsnoop(){
    skipIfNotExist ${BCCPATH}/$(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    assertPassTerm ${BCCPATH}/killsnoop &> ${logfile}
    assertPassOrKeyboardInt $? ${logfile} $(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
}

test_mdflush(){
    skipIfNotExist ${BCCPATH}/$(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    assertPassInt ${BCCPATH}/mdflush &> ${logfile}
    assertPassOrKeyboardInt $? ${logfile} $(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
}

test_mountsnoop(){
    skipIfNotExist ${BCCPATH}/$(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    assertPassInt ${BCCPATH}/mountsnoop &> ${logfile}
    assertPassOrKeyboardInt $? ${logfile} $(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
}

test_nfsdist(){
    skipIfNotExist ${BCCPATH}/$(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
    modprobe nfs
    modprobe nfsv4
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    ${BCCPATH}/nfsdist 2 2 &> ${logfile}
    assertPassOrKeyboardInt $? ${logfile} $(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
}

test_nfsslower(){
    skipIfNotExist ${BCCPATH}/$(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
    modprobe nfs
    modprobe nfsv4
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    assertPassInt ${BCCPATH}/nfsslower &> ${logfile}
    assertPassOrKeyboardInt $? ${logfile} $(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
}

test_offcputime(){
    skipIfNotExist ${BCCPATH}/$(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    ${BCCPATH}/offcputime 2 &> ${logfile}
    assertPassOrKeyboardInt $? ${logfile} $(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
}

test_offwaketime(){
    skipIfNotExist ${BCCPATH}/$(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    ${BCCPATH}/offwaketime 2 &> ${logfile}
    assertPassOrKeyboardInt $? ${logfile} $(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
}

test_oomkill(){
    skipIfNotExist ${BCCPATH}/$(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    assertPassInt ${BCCPATH}/oomkill &> ${logfile}
    assertPassOrKeyboardInt $? ${logfile} $(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
}

test_opensnoop(){
    skipIfNotExist ${BCCPATH}/$(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    ${BCCPATH}/opensnoop -d 2 &> ${logfile}
    assertPassOrKeyboardInt $? ${logfile} $(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
}

test_pidpersec(){
    skipIfNotExist ${BCCPATH}/$(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    assertPassInt ${BCCPATH}/pidpersec &> ${logfile}
    assertPassOrKeyboardInt $? ${logfile} $(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
}

test_runqlat(){
    skipIfNotExist ${BCCPATH}/$(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    ${BCCPATH}/runqlat 2 2 &> ${logfile}
    assertPassOrKeyboardInt $? ${logfile} $(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
}

test_runqslower(){
    skipIfNotExist ${BCCPATH}/$(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    assertPassInt ${BCCPATH}/runqslower &> ${logfile}
    assertPassOrKeyboardInt $? ${logfile} $(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
}

test_slabratetop(){
    skipIfNotExist ${BCCPATH}/$(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    ${BCCPATH}/slabratetop 2 2 &> ${logfile}
    assertPassOrKeyboardInt $? ${logfile} $(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
}

test_sofdsnoop(){
    skipIfNotExist ${BCCPATH}/$(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    ${BCCPATH}/sofdsnoop -d 2 &> ${logfile}
    assertPassOrKeyboardInt $? ${logfile} $(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
}

test_solisten(){
    skipIfNotExist ${BCCPATH}/$(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    assertPassInt15 ${BCCPATH}/solisten &> ${logfile}
    assertPassOrKeyboardInt $? ${logfile} $(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
}

test_syncsnoop(){
    skipIfNotExist ${BCCPATH}/$(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    assertPassInt ${BCCPATH}/syncsnoop &> ${logfile}
    assertPassOrKeyboardInt $? ${logfile} $(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
}

test_tcpconnect(){
    skipIfNotExist ${BCCPATH}/$(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    assertPassInt15 ${BCCPATH}/tcpconnect &> ${logfile}
    assertPassOrKeyboardInt $? ${logfile} $(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
}

test_tcpconnlat(){
    skipIfNotExist ${BCCPATH}/$(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    assertPassInt15 ${BCCPATH}/tcpconnlat &> ${logfile}
    assertPassOrKeyboardInt $? ${logfile} $(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
}

test_tcplife(){
    skipIfNotExist ${BCCPATH}/$(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    assertPassInt15 ${BCCPATH}/tcplife &> ${logfile}
    assertPassOrKeyboardInt $? ${logfile} $(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
}

test_tcpretrans_l(){
    skipIfNotExist ${BCCPATH}/$(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    assertPassInt15 ${BCCPATH}/tcpretrans -l &> ${logfile}
    assertPassOrKeyboardInt $? ${logfile} $(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
}

test_tcpsubnet(){
    skipIfNotExist ${BCCPATH}/$(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    assertPassInt15 ${BCCPATH}/tcpsubnet &> ${logfile}
    assertPassOrKeyboardInt $? ${logfile} $(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
}

test_tcptop(){
    skipIfNotExist ${BCCPATH}/$(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    ${BCCPATH}/tcptop 2 2 &> ${logfile}
    assertPassOrKeyboardInt $? ${logfile} $(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
}

test_tcptracer(){
    skipIfNotExist ${BCCPATH}/$(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    assertPassInt15 ${BCCPATH}/tcptracer &> ${logfile} &
    assertPassOrKeyboardInt $? ${logfile} $(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
}

test_ttysnoop(){
    skipIfNotExist ${BCCPATH}/$(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    assertPassInt ${BCCPATH}/ttysnoop /dev/tty0 &> ${logfile}
    assertPassOrKeyboardInt $? ${logfile} $(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
}

test_vfsstat(){
    skipIfNotExist ${BCCPATH}/$(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    ${BCCPATH}/vfsstat 2 2 &> ${logfile}
    assertPassOrKeyboardInt $? ${logfile} $(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
}

test_wakeuptime(){
    skipIfNotExist ${BCCPATH}/$(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    ${BCCPATH}/wakeuptime 4 &> ${logfile}
    assertPassOrKeyboardInt $? ${logfile} $(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
}

test_xfsdist(){
    skipIfNotExist ${BCCPATH}/$(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
    modprobe xfs
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    ${BCCPATH}/xfsdist 2 2 &> ${logfile}
    assertPassOrKeyboardInt $? ${logfile} $(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
}

test_xfsslower(){
    skipIfNotExist ${BCCPATH}/$(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
    modprobe xfs
    logfile=${LOGPREFIX}/${FUNCNAME[ 0 ]}.log
    assertPassInt ${BCCPATH}/xfsslower &> ${logfile}
    assertPassOrKeyboardInt $? ${logfile} $(echo ${FUNCNAME[ 0 ]} | awk -F '_' '{print $2}')
}

. $(dirname $0)/../lib/include
