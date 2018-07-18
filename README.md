# 注意！
* 1

```css
经过反复试验，keepalived+haproxy/nginx的k8s高可用方案行不通，最终只是采取keepalived的方式完成
```
* 2

```css
vip最好选取实际存在的同网段地址，端口依旧设置成6443
```

* 3

```css
当启动pod出现以下类似错误时：试着给proxy.j2配置中加上这两个配置"--masquerade-all=true --proxy-mode=ipvs"
错误：Error while initializing connection to Kubernetes apiserver. This most likely means that the cluster is misconfigured (e.g., it has invalid apiserver certificates or service accounts configuration) or the --apiserver-host param points to a server that does not exist. Reason: Get https://10.68.0.1:443/version: dial tcp 10.68.0.1:443: getsockopt: connection refused
```