#!/bin/sh
cat hosts-test|awk 'NR>1'|while read x
do
  ip=`echo $x|awk '{print $1}'`
  passwd=`echo $x|awk '{print $3}'|cut -d"=" -f2`
  sshpass -p $passwd ssh-copy-id $ip
done
