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

kprobe_list="biolatency|biolatency|biosnoop|biotop|bitesize|cachestat|cachetop|cpudist|dcsnoop|dcsnoop|dcstat|execsnoop|ext4dist|ext4slower|filelife|fileslower|filetop|hardirqs|killsnoop|mdflush|mountsnoop|nfsdist|nfsslower|offcputime|offwaketime|oomkill|opensnoop|pidpersec|runqlat|runqslower|slabratetop|sofdsnoop|solisten|syncsnoop|tcpconnect|tcpconnlat|tcplife|tcpretrans|tcpsubnet|tcptop|tcptracer|ttysnoop|vfsstat|wakeuptime|xfsdist|xfsslower"

for s in $(ls $BCCPATH | egrep -v $kprobe_list) ; do

eval "test_$s(){
    logfile=\${LOGPREFIX}/$s.log
    exec \${BCCPATH}/$s &>> \${logfile} &
    tpid=\$!
    sleep 5
    /usr/bin/kill -INT \$tpid
    sleep 3
    assertTrue \"log should not be empty\" \"[ -s \${logfile} ]\"
}
"
done

suite(){
    for s in $(ls $BCCPATH | egrep -v $kprobe_list) ; do
	    suite_addTest "test_$s"
    done
}

. $(dirname $0)/../lib/include

