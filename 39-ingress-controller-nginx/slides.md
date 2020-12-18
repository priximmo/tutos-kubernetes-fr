%title: Kubernetes 
%author: xavki
%Vidéos: [Formation Kubernetes](https://www.youtube.com/playlist?list=PLn6POgpklwWqfzaosSgX2XEKpse5VY2v5)
%blog: [Xavki Blog](https://xavki.blog)


# KUBESPRAY & INGRESS CONTROLLER NGINX


<br>

```

                                          6443  +------------+
                                                |            |
       192.168.7.130      +------------+   +---->  Master1   |
                          |            |   |    |            |
                    +-----+  HAPROXY1  |   |    +------------+
                          |            |   |
                          +------------+   |
                          |            +---+    +------------+
                          |                |    |            |
                  80/443  |                +---->  Master2   |
                          |                     |            |
           +------------+ |    +------------+   +------------+
           |            | |    |            |
           |  Knode01   <------>  Knode0X   |
           |            |      |            |
           +------------+      +------------+
```


------------------------------------------------------------------------

# KUBESPRAY & INGRESS CONTROLLER NGINX



<br>

* FLUX :

0. Haproxy 80/443 >> KnodeXX

1. Knode >> pod/daemonset nginx

2. nginx >> ingress

3. ingress >> service

4. service >> pods



-----------------------------------------------------------------------


# KUBESPRAY & INGRESS CONTROLLER NGINX


<br>

* installation avec kubespray :

```
vim kubespray/inventory/mykub/group_vars/k8s-cluster/addons.yml
# Nginx ingress controller deployment
ingress_nginx_enabled: true
ingress_nginx_host_network: true
ingress_publish_status_address: ""
ingress_nginx_nodeselector:
  kubernetes.io/os: "linux"
# ingress_nginx_tolerations:
#   - key: "node-role.kubernetes.io/master"
#     operator: "Equal"
#     value: ""
#     effect: "NoSchedule"
ingress_nginx_namespace: "ingress-nginx"
ingress_nginx_insecure_port: 80
ingress_nginx_secure_port: 443
```

Rq : https://docs.nginx.com/nginx-ingress-controller/installation/installation-with-manifests/

---------------------------------------------------------------------------


# KUBESPRAY & INGRESS CONTROLLER NGINX

<br>

* configuration des haproxy

```
listen kubernetes-ingress
  bind *:80
  mode tcp
  option log-health-checks
  server knode01 192.168.7.123:80 check
```

<br>

* check du namespace ingress-nginx

```
kubectl get ns
kubectl get all -n ingress-nginx
```

<br>

* check de la réponse nginx

```
curl 192.168.7.130
```
