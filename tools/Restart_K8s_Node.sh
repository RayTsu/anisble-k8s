#!/bin/sh
# 重启的顺序为：flanneld、docker、kubelet、kube-proxy
function chk_service_status(){
  docker_status=`echo $(get_status_code docker)`
  kubelet_status=`echo $(get_status_code kubelet)`
  kube_proxy_status=`echo $(get_status_code kube-proxy)`
  flanneld_status=`echo $(get_status_code flanneld)`
  
  if [[  $docker_status -eq 0 ]];then
    echo -e "\033[40;32mdocker is running\033[0m"
  else 
    echo -e "\033[40;31mdocker is not running\033[0m"
    restart_k8s_service docker
  fi

  if [[  $kubelet_status -eq 0 ]];then
    echo -e "\033[40;32mkubelet is running\033[0m"
  else
    echo -e "\033[40;31mkubelet is not running\033[0m"
    restart_k8s_service kubelet
  fi
  
  if [[  $kube_proxy_status -eq 0 ]];then
    echo -e "\033[40;32mkube-proxy is running\033[0m"
  else
    echo -e "\033[40;31mkube-proxy is not running\033[0m"
    restart_k8s_service kube-proxy
  fi

  if [[  $flanneld_status -eq 0 ]];then
    echo -e "\033[40;32mflanneld is running\033[0m"
  else
    echo -e "\033[40;31mflanneld is not running\033[0m"
    restart_k8s_service flanneld
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

function restart_k8s_service(){
  echo "**********$1 restart beginning!**********"
  echo "**********$1 is restarting**********"
  systemctl restart $1
  sleep 2
  echo "**********$1 restart complete!**********"
}

chk_service_status
