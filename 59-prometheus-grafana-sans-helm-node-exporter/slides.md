%title: Kubernetes 
%author: xavki

# PROMETHEUS : SANS HELM - AJOUT DE NODE EXPORTER


<br>
* déroulement
	1. RBAC / SA / CRB > droits pour le user
	2. PV > NFS
	3. PVC > affectation du volume
	4. Configmap > conf prometheus
	5. Deployment
	6. Service

* ajout :
	1. Ajout du daemonset > node exporter sur tous les nodes
	2. changement de conf de prometheus > autodiscovery
	
