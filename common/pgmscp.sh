#!/bin/bash
if [ $# -ne 3 ] && [ $# -ne 4 ] ; then
    echo "usage : $0 [<user>] <hosts_file> <src> <dest>"
    exit 1
fi

user=`whoami`
if [ $# -eq 4 ] ; then
    user=$1
    shift
fi

hosts_file=$1
src=$2
dst=$3

dest_servers=($(awk '{print $1}' $hosts_file))
for dest_server in ${dest_servers[@]}
do
    scp -qr $src $user@$dest_server:$dst
    if [ $? -ne 0 ]; then
        echo "failed to transfer $src to $user@$dest_server:$dst"
    else
        echo "successfully transfer $src to $user@$dest_server:$dst"
    fi
done
