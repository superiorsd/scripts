#!/bin/bash
echo $#
if [ $# -ne 2 ] && [ $# -ne 3 ] ; then
    echo "usage : $0 [<user>] <hosts_file> <cmd>"
    exit 1
fi

user=`whoami`
if [ $# -eq 3 ] ; then
    user=$1
    shift
fi

hosts_file=$1
shift
cmd=$*

dest_servers=($(awk '{print $1}' $hosts_file))
for dest_server in ${dest_servers[@]}
do
    ssh -q $user@$dest_server "$cmd"
done
