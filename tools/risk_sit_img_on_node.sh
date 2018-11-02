#!/bin/sh
pods_name=(`kubectl get pods -owide|grep -v rabbit|grep -v lbpm|grep -v redis|grep -v mysql|grep -v cwbi|awk 'NR>1{print $1}'`)
ips=(`kubectl get pods -owide|grep -v rabbit|grep -v lbpm|grep -v redis|grep -v mysql|grep -v cwbi|awk 'NR>1{print $7}'`)
img_name=(`kubectl get deploy -owide|grep -v rabbit|grep -v lbpm|grep -v redis|grep -v mysql|grep -v cwbi|awk 'NR>1{print $8}'`)
pods_len=${#pods_name[@]}
a=()
b=()
c=()
d=()
for ((i=0;i<=(($pods_len-1));i++))
do
  if [[ "${ips[$i]}" == "192.168.11.54" ]];then
    a+=(${img_name[$i]})
    continue
  elif [[ "${ips[$i]}" == "192.168.11.55" ]];then
    b+=(${img_name[$i]})
    continue
  elif [[ "${ips[$i]}" == "192.168.11.56" ]];then
    c+=(${img_name[$i]})
    continue
  elif [[ "${ips[$i]}" == "192.168.11.57" ]];then
    d+=(${img_name[$i]})
    continue
  fi
done
echo -e "192.168.11.54宿主机上的镜像：\033[40;31m${a[@]}\033[0m"
echo -e "192.168.11.55宿主机上的镜像：\033[40;32m${b[@]}\033[0m"
echo -e "192.168.11.56宿主机上的镜像：\033[40;33m${c[@]}\033[0m"
echo -e "192.168.11.57宿主机上的镜像：\033[40;34m${d[@]}\033[0m"
