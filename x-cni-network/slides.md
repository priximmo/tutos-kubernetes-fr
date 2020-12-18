%title: Kubernetes 
%author: xavki
%Vidéos: [Formation Kubernetes](https://www.youtube.com/playlist?list=PLn6POgpklwWqfzaosSgX2XEKpse5VY2v5)
%blog: [Xavki Blog](https://xavki.blog)


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

* déploiement par pod

----------------------------------------------------------------------------------

Flannel :


* vxlan

* ipv4 seulement

* etcd comme stockage

* flanned : agent créant des sous réseau sur les hôtes

* un seul réseau par daemonset (pod) : limité

----------------------------------------------------------------------------------


WeaveNet :



* vxlan L2

* ipv4 ou ipv6

* attention : master > 2cpu

* stockage etcd

* lancement par DaemonSet

* pas de pods sur le master

* chiffrage des communications par mot de passe



-----------------------------------------------------------------------------------

Cillium :



* ipv4 ou ipv6

* couches L3/L4 et L7 (permet des règles fines de filtrage)

* filtrage BPF (Berkely Packet Filter) donc sans iptables => plus efficace

* Cillium agent sur chaque noeud

* mode overlay par défaut (ou routage natif plus compliqué)

* propres règles de routage/filtrage par fichier de conf kub

* déploiement par pod

-----------------------------------------------------------------------------------

Contiv :

* solution CISCO

* vxlan ou BGP L3

* ipv4 ou ipv6

* stockage etcd

* déploiement : netplugin / netmaster

* bandwith : limitation bande passante

* isolation : autorisation de flux

* déploiement par daemonset


Flannel :













-----------------------------------------------------------
