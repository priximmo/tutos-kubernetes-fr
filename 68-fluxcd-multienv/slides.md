%title: KUBERNETES
%author: xavki



# FLUX : CLI - 


<br>

```
fluxctl deautomate --workload=default:deployment/hello-un
```

* réactivation

```
fluxctl automate --workload=default:deployment/hello-un
```

* via les manifests avec l'annotation

```
fluxcd.io/automated: "true" 
```

* rollback d'une image (attention image)

```
fluxctl release --workload=default:deployment/hello-un --user=xavki --message="rollback" --update-image=paulbouwer/hello-kubernetes:1.7
```

```
fluxctl list-images --workload=default:deployment/hello-un
fluxctl sync
fluxctl list-workloads
```
