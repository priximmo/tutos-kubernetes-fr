%title: Kubernetes 
%author: xavki
%Vidéos: [Formation Kubernetes](https://www.youtube.com/playlist?list=PLn6POgpklwWqfzaosSgX2XEKpse5VY2v5)
%blog: [Xavki Blog](https://xavki.blog)

# PROMETHEUS : SANS HELM - CADVISOR + DASHBOARDS


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
	11. persistent volume grafana
	12. pvc grafana
	13. deployment grafana
	14. service grafana
	15. ingress grafana

* ajout: cadvisor
	1. configmap conf prometheus
	2. dashboards : 893, 1890 
