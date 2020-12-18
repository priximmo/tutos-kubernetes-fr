%title: Kubernetes 
%author: xavki
%Vidéos: [Formation Kubernetes](https://www.youtube.com/playlist?list=PLn6POgpklwWqfzaosSgX2XEKpse5VY2v5)
%blog: [Xavki Blog](https://xavki.blog)

# PROMETHEUS : SANS HELM


<br>

A prendre en compte :


<br>

* création d'un répertoire local pour stockage hostpath (pv)

* sur les nodes/workers :

```
sudo mkdir -p /srv/prometheus
sudo chmod 775 -R /srv/prometheus
sudo apt-get install nfs-kernel-server
ou sudo yum -y install nfs-utils rpcbind
sudo vim /etc/exports
/srv/prometheus 192.168.11.0/24(rw,sync,no_root_squash)
#sudo systemctl restart nfs rpcbind
sudo exportfs -a
# test sudo mount -t nfs 192.168.11.120:/srv/prometheus /tmp
```

* sans nfs

```
ssh -o "StrictHostKeyChecking no" vagrant@node05 "sudo mkdir -p /prometheus && sudo chmod -R 775 /prometheus"
```

* déroulement
	1. RBAC / SA / CRB > droits pour le user
	2. PV > NFS
	3. PVC > affectation du volume
	4. Configmap > conf prometheus
	5. Deployment
	6. Service

	
