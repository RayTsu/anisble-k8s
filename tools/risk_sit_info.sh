#!/bin/sh

pods_name=(`kubectl get pods -owide|grep -v rabbit|grep -v lbpm|grep -v redis|grep -v mysql|grep -v cwbi|awk 'NR>1{print $1}'`)
ip=(`kubectl get pods -owide|grep -v rabbit|grep -v lbpm|grep -v redis|grep -v mysql|grep -v cwbi|awk 'NR>1{print $7}'`)
deploy_name=(`kubectl get deploy -owide|grep -v rabbit|grep -v lbpm|grep -v redis|grep -v mysql|grep -v cwbi|awk 'NR>1{print $1}'`)
img_name=(`kubectl get deploy -owide|grep -v rabbit|grep -v lbpm|grep -v redis|grep -v mysql|grep -v cwbi|awk 'NR>1{print $8}'`)
pods_len=${#pods_name[@]}
for ((i=0;i<=$((pods_len-1));i++))
do
echo -e "pod名称：\033[40;31m${pods_name[$i]}，\033[0mip地址：\033[40;31m${ip[$i]}，\033[0m镜像名称：\033[40;31m${img_name[$i]}\033[0m\n"
done
