%title: Kubernetes 
%author: xavki
%Vidéos: [Formation Kubernetes](https://www.youtube.com/playlist?list=PLn6POgpklwWqfzaosSgX2XEKpse5VY2v5)
%blog: [Xavki Blog](https://xavki.blog)


# KUBESPRAY & HAPROXY : api-server haute disponibilité

<br>

* cocorico = solution 100% française

<br>

* 1. installation d'un cluster haproxy/keepalived
		* load balancer sur les masters
		* fault tolerance des load balancers
		* vip partagée entre les haproxy

* 2. installation via kubespray
		* prise en compte de la vip par kubernetes
		* 2 masters / 1 node

* 3. test


----------------------------------------------------------------------------------------------


```

                                        +------------+
                                        |            |
                  +------------+   +---->  Master1   |
                  |            |   |    |            |
            +-----+  HAPROXY1  |   |    +------------+
            |     |            |   |
            |     +------------+   |
            |                  +---+    +------------+
  192.168.7.130                    |    |            |
            |     +------------+   +---->  Master2   |
            |     |            |   |    |            |
            +-----+  HAPROXY2  |   |    +------------+
                  |            |   |
                  +------------+   |
                                   |    +------------+
                                   |    |            |
                                   +---->  Master3   |
                                        |            |
                                        +------------+
```


----------------------------------------------------------------------------------------------

# KUBESPRAY & HAPROXY : api-server haute disponibilité


<br>

* installation haproxy & keepalived

```
sudo yum install -y keepalived haproxy psmisc.x86_64
setsebool -P haproxy_connect_any=1
```

https://github.com/kubernetes-sigs/kubespray/blob/master/docs/ha-mode.md

```
listen stats
    bind *:9000
    stats enable
    stats uri /stats
    stats refresh 2s
    stats auth xavki:pasword
listen kubernetes-apiserver-https
    bind *:6443
    mode tcp
    option log-health-checks
    timeout client 3h
    timeout server 3h
    server master1 192.168.7.121:6443 check check-ssl verify none inter 10000
    server master2 192.168.7.122:6443 check check-ssl verify none inter 10000
    balance roundrobin
```

<br>

* puis conf de /etc/keepalived/keepalived.conf

-------------------------------------------------------------------

