%title: Kubernetes 
%author: xavki
%Vidéos: [Formation Kubernetes](https://www.youtube.com/playlist?list=PLn6POgpklwWqfzaosSgX2XEKpse5VY2v5)
%blog: [Xavki Blog](https://xavki.blog)


# KUBESPRAY & HAPROXY : api-server haute disponibilité


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


------------------------------------------------------------------------

# KUBESPRAY & HAPROXY : kubespray

<br>

* configuration de kubespray

```
cp -r inventory/sample inventory/mykub
vim inventory/mykub/group_vars/all/all.yml
## External LB example config
apiserver_loadbalancer_domain_name: "elb.kub"
loadbalancer_apiserver:
  address: 192.168.7.130
  port: 6443
```

* cf fichier inventory (exemple non représentatif)


--------------------------------------------------------------------


# KUBESPRAY & HAPROXY : kubectl

<br>

* installation de kubectl sur une machine distante

```
cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF
yum install -y kubectl
```

* check avant récupération des certificats

```
kubectl cluster-info
```

--------------------------------------------------------------------------

# KUBESPRAY : certificat d'admin


<br>

* sur un des master, récupération du certificat

```
cat /etc/kubernetes/admin.conf
```

<br>

* modification de /etc/hosts pour elb.kub

<br>

* ajout du certificat sur la machine distante

```
mkdir -p ~/.kube
vim ~/.kube/config
kubectl cluster-info
kubectl get nodes
```

------------------------------------------------------------------


# TEST : suppression haproxy et master


<br>

* ouverture de la GUI haproxy


<br>

* pas de bol je perds un master...

```
ansible-playbook -i inventory/mykub/inventory.ini -k -K -b -e "node=kmaster01" remove-node.yml
```

<br>

* et en plus je perds un haproxy...

```
ip a
sudo systemctl status haproxy
```
