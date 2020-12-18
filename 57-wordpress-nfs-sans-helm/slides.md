%title: Kubernetes 
%author: xavki
%Vidéos: [Formation Kubernetes](https://www.youtube.com/playlist?list=PLn6POgpklwWqfzaosSgX2XEKpse5VY2v5)
%blog: [Xavki Blog](https://xavki.blog)

# WORDPRESS : installation avec NFS (sans HELM)


<br>

* Wordpress :
	* datas applicatives (wordpress)
	* datas base de données (mysql)

<br>

* création d'un répertoire local pour stockage hostpath (pv)

* sur les nodes/workers :

```
sudo mkdir -p /srv/wordpress/{db,files}
sudo chmod 777 -R /srv/wordpress/
sudo apt-get install nfs-kernel-server
ou sudo yum -y install nfs-utils rpcbind
sudo vim /etc/exports
/srv/wordpress/db 192.168.11.0/24(rw,sync,no_root_squash)
/srv/wordpress/files 192.168.11.0/24(rw,sync,no_root_squash)
sudo systemctl restart nfs rpcbind
sudo exportfs -a
# test sudo mount -t nfs 192.168.11.120:/srv/wordpress/db /tmp
```

* sans nfs

```
ssh -o "StrictHostKeyChecking no" vagrant@node05 "sudo mkdir -p /wordpress/files && sudo mkdir -p /wordpress/db && sudo chmod -R 775 /wordpress"
```

```
echo -n 'monpassword' | base64
```
