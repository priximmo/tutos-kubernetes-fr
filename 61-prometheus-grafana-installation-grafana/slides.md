%title: Kubernetes 
%author: xavki
%Vidéos: [Formation Kubernetes](https://www.youtube.com/playlist?list=PLn6POgpklwWqfzaosSgX2XEKpse5VY2v5)
%blog: [Xavki Blog](https://xavki.blog)

# PROMETHEUS : SANS HELM - INSTALLATION GRAFANA


<br>

* déroulement
	1. RBAC / SA / CRB > droits pour le user
	2. PV > NFS
	3. PVC > affectation du volume
	4. Configmap > conf prometheus
	5. Deployment
	6. Service
	7. Ajout du daemonset > node exporter sur tous les nodes
	8. changement de conf de prometheus > autodiscovery
	9. deployement redis
	10. service redis

* ajout :
	1. persistent volume grafana
	2. pvc grafana
	3. deployment grafana
	4. service grafana
	5. ingress grafana
