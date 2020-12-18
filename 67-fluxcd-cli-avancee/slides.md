%title: KUBERNETES
%author: xavki
%Vidéos: [Formation Kubernetes](https://www.youtube.com/playlist?list=PLn6POgpklwWqfzaosSgX2XEKpse5VY2v5)
%blog: [Xavki Blog](https://xavki.blog)



# FLUX : CLI - suite


<br>

```
fluxctl deautomate --workload=default:deployment/hello-un
```

<br>

* réactivation

```
fluxctl automate --workload=default:deployment/hello-un
```

<br>

* via les manifests avec l'annotation

```
fluxcd.io/automated: "true" 
```

<br>

* rollback d'une image (attention image)

```
fluxctl release --workload=default:deployment/hello-un --user=xavki --message="rollback" --update-image=paulbouwer/hello-kubernetes:1.7
```

```
fluxctl list-images --workload=default:deployment/hello-un
fluxctl sync
fluxctl list-workloads
```

----------------------------------------------------------------------

# FLUX : CLI - suite


<br>
* options de fluxctl install

```
fluxctl install --help
```

* exemple 

```
--registry-disable-scanning
```

<br>

* suppression des ressources avec flux en auto

```
--sync-garbage-collection
```
