#!/bin/sh

function chk_service_status(){
  docker_status=`echo $(get_status_code docker.service)`
  kubelet_status=`echo $(get_status_code kubelet.service)`
  kube_proxy_status=`echo $(get_status_code kube-proxy.service)`
  flanneld_status=`echo $(get_status_code flanneld.service)`
  
  if [[  $docker_status -eq 0 ]];then
    echo -e "\033[40;32mdocker is running\033[0m"
  else 
    echo -e "\033[40;31mdocker is not running\033[0m"
  fi

  if [[  $kubelet_status -eq 0 ]];then
    echo -e "\033[40;32mkubelet is running\033[0m"
  else
    echo -e "\033[40;31mkubelet is not running\033[0m"
  fi
  
  if [[  $kube_proxy_status -eq 0 ]];then
    echo -e "\033[40;32mkube-proxy is running\033[0m"
  else
    echo -e "\033[40;31mkube-proxy is not running\033[0m"
  fi

  if [[  $flanneld_status -eq 0 ]];then
    echo -e "\033[40;32mflanneld is running\033[0m"
  else
    echo -e "\033[40;31mflanneld is not running\033[0m"
  fi
}

function get_status_code(){
  systemctl status $1 >/dev/null
  if [[ $? -eq 0 ]];then
    echo 0
  else
    echo 1
  fi
}

chk_service_status
