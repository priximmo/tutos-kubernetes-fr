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

