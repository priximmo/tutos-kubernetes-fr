%title: Kubernetes 
%author: xavki


# CNI : installer un network pour kubernetes


* Container Network Interface

* objectif : communication entre les nodes et donc entre les pods

* CNI : librairies en GO, interaction avec le système du Host

* conf : /etc/cni/net.d


## underlay vs overlay


* underlay : réseau physique sous linux

* overlay : réseau virtuel (base de vxlan), plus lent

* Kubernetes permet les deux


## Les CNI Kubernetes

* liste: Calico, Cilium, Flannel, Weave

* n'ont pas tous les mêmes périmètres


Calico :


* ipv4 ou ipv6

* kube-proxy comme filtre (via iptables)

* ethernet L2 ou IPinIP L3 (encapsulation)

* composants : 
			*	Felix (adressage extérieur)
			* BIRD pour le BGP (Border Gateway Protocol)
			* confd applique les changements de conf de BGP dans etcd
			* etcd stockage de configurations











-----------------------------------------------------------
