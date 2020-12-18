%title: Kubernetes 
%author: xavki
%Vidéos: [Formation Kubernetes](https://www.youtube.com/playlist?list=PLn6POgpklwWqfzaosSgX2XEKpse5VY2v5)
%blog: [Xavki Blog](https://xavki.blog)

# KUBESPRAY


<br>

* installation vagrant : cf Vagrantfile

* 1 machine deploiement, 3 master et 2 nodes 

* attention : bonne connexion et prend du temps

<br>

* kubespray :
	* multi provider : on prem, openstack, gcp...
	* automatisation via ansible
	* idempotence
	* assertions
	* configuration de nombreux éléments
	* container runtime : docker vs cri
	* master/nodes/etcd splittés
	* choix pods réseaux : flannel / calico...
	* dashboard
	* ingress controller
	* certificats
	* attention cache (gather_facts si modifs après coup)

* utilisation du user vagrant (idéal utilisateur dédié avec clef ssh)

--------------------------------------------------------------------------------------

# Kubespray : Préparation


<br>

* sur la machine de déploiement : deploykub

<br>

* clone du dépôt

```
git clone https://github.com/kubernetes-sigs/kubespray.git
```

<br>

* installation de sshpass (ansble password)

```
yum install sshpass
```

<br>

* installation des requirements

```
pip3 install -r requirements.txt
```

<br>

* on peut spécifier la conf du ansible.cfg

```
[privilege_escalation]
become=True
become_method=sudo
become_user=root
become_ask_pass=False
```

---------------------------------------------------------------------------------------

# Kubespray : inventory ansible


<br>

* copie du sample

```
cp -rfp inventory/sample inventory/my-cluster
```

* exemple : 3 master (avec etcd) et 2 nodes 
```
[all] # d�claration des nodes
node01 ansible_host=192.168.6.121  ip=192.168.6.121 etcd_member_name=etcd1
node02 ansible_host=192.168.6.122  ip=192.168.6.122 etcd_member_name=etcd2
node03 ansible_host=192.168.6.123  ip=192.168.6.123 etcd_member_name=etcd3
node04 ansible_host=192.168.6.124  ip=192.168.6.124
node05 ansible_host=192.168.6.125  ip=192.168.6.125
[kube-master]
node01
node02
node03
[etcd]
node01
node02
node03
[kube-node]
node04
node05
[calico-rr]
[k8s-cluster:children]
kube-master
kube-node
calico-rr
```

ansible-playbook -i inventory/my-cluster/inventory.ini -u vagrant -k -b cluster.yml
