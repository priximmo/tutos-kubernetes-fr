%title: KUBERNETES
%author: xavki
%Vidéos: [Formation Kubernetes](https://www.youtube.com/playlist?list=PLn6POgpklwWqfzaosSgX2XEKpse5VY2v5)
%blog: [Xavki Blog](https://xavki.blog)



# FLUX : la CLI


<br>

* CLI fluxctl

```
Available Commands:
  automate       Turn on automatic deployment for a workload.
  completion     Output shell completion code for the specified shell (bash, zsh, or fish)
  deautomate     Turn off automatic deployment for a workload.
  help           Help about any command
  identity       Display SSH public key
  install        Print and tweak Kubernetes manifests needed to install Flux in a Cluster
  list-images    Show deployed and available images.
  list-workloads List workloads currently running in the cluster.
  lock           Lock a workload, so it cannot be deployed.
  policy         Manage policies for a workload.
  release        Release a new version of a workload.
  save           save workload definitions to local files in cluster-native format
  sync           synchronize the cluster with the git repository, now
  unlock         Unlock a workload, so it can be deployed.
  version        Output the version of fluxctl
```

-----------------------------------------------------------------------------------------------------

# FLUX : la CLI


<br>

* option de flux (dans le cluster)


```
      --connect string                        connect to an upstream service e.g., Weave Cloud, at this base address
      --docker-config string                  path to a docker config to use for image registry credentials
      --git-branch string                     branch of git repo to use for Kubernetes manifests (default "master")
      --git-ci-skip                           append "[ci skip]" to commit messages so that CI will skip builds
      --git-ci-skip-message string            additional text for commit messages, useful for skipping builds in CI. Use this to supply specific text, or set --git-ci-skip
      --git-email string                      email to use as git committer (default "support@weave.works")
      --git-gpg-key-import string             keys at the path given (either a file or a directory) will be imported for use in signing commits
      --git-label string                      label to keep track of sync progress; overrides both --git-sync-tag and --git-notes-ref
      --git-notes-ref string                  ref to use for keeping commit annotations in git notes (default "flux")
      --git-path strings                      relative paths within the git repo to locate Kubernetes manifests
      --git-poll-interval duration            period at which to poll git repo for new commits (default 5m0s)
      --git-set-author                        if set, the author of git commits will reflect the user who initiated the commit and will differ from the git committer.
      --git-signing-key string                if set, commits will be signed with this GPG key
      --git-sync-tag string                   tag to use to mark sync progress for this cluster (default "flux-sync")
      --git-timeout duration                  duration after which git operations time out (default 20s)
      --git-url string                        URL of git repo with Kubernetes manifests; e.g., git@github.com:weaveworks/flux-get-started
      --git-user string                       username to use as git committer (default "Weave Flux")
      --k8s-namespace-whitelist strings       experimental, optional: restrict the view of the cluster to the namespaces listed. All namespaces are included if this is not set.
      --k8s-secret-data-key string            data key holding the private SSH key within the k8s secret (default "identity")
      --k8s-secret-name string                name of the k8s secret used to store the private SSH key (default "flux-git-deploy")
      --k8s-secret-volume-mount-path string   mount location of the k8s secret storing the private SSH key (default "/etc/fluxd/ssh")
```

-----------------------------------------------------------------------------

# FLUX : la CLI


<br>

* option de flux (dans le cluster)


```
      --kubernetes-kubectl string             optional, explicit path to kubectl tool
  -l, --listen string                         listen address where /metrics and API will be served (default ":3030")
      --listen-metrics string                 listen address for /metrics endpoint
      --memcached-hostname string             hostname for memcached service. (default "memcached")
      --memcached-service string              SRV service used to discover memcache servers. (default "memcached")
      --memcached-timeout duration            maximum time to wait before giving up on memcached requests. (default 1s)
      --registry-burst int                    maximum number of warmer connections to remote and memcache (default 10)
      --registry-ecr-exclude-id strings       do not scan ECR for images in these AWS account IDs; the default is to exclude the EKS system account (default [602401143452])
      --registry-ecr-include-id strings       restrict ECR scanning to these AWS account IDs; if empty, all account IDs that aren't excluded may be scanned
      --registry-ecr-region strings           restrict ECR scanning to these AWS regions; if empty, only the cluster's region will be scanned
      --registry-exclude-image strings        do not scan images that match these glob expressions; the default is to exclude the 'k8s.gcr.io/*' images (default [k8s.gcr.io/*])
      --registry-insecure-host strings        let these registry hosts skip TLS host verification and fall back to using HTTP instead of HTTPS; this allows man-in-the-middle attacks, so use with extreme caution
      --registry-poll-interval duration       period at which to check for updated images (default 5m0s)
      --registry-rps float                    maximum registry requests per second per host (default 50)
      --registry-trace                        output trace of image registry requests to log
      --ssh-keygen-bits uint                  -b argument to ssh-keygen (default unspecified)
      --ssh-keygen-dir string                 directory, ideally on a tmpfs volume, in which to generate new SSH keys when necessary
      --ssh-keygen-type string                -t argument to ssh-keygen (default unspecified)
      --sync-garbage-collection               experimental; delete resources that were created by fluxd, but are no longer in the git repo
      --sync-interval duration                apply config in git to cluster at least this often, even if there are no new commits (default 5m0s)
      --token string                          authentication token for upstream service
      --version                               get version number
```


-----------------------------------------------------------------------------

# FLUX : la CLI


<br>

* configuration de fluxctl via le deployment

```
kubectl edit deployment flux  -n fluxcd
```

<br>

* Exemple changement de la fréquence de sync

```
--sync-interval=1m
--git-branch=prod
```

<br>

* liste des déploiements

```
fluxctl list-workloads --k8s-fwd-ns fluxcd
```

<br>

* éviter de resaisir le namespace de flux

```
export FLUX_FORWARD_NAMESPACE=fluxcd
```

<br>

* retrouver la clef ssh

```
fluxctl identity
```

<br>

* ou via la collecte du secret

```
kubectl get secrets flux-git-deploy -n fluxcd -ojsonpath='{.data.identity}' | base64 -d
```

----------------------------------------------------------------------------------------------------------

# FLUX : la CLI



<br>

* ou via une clef déjà générée

```
kubectl create secret generic flux-git-deploy --from-file=identity=/full/path/to/private_key
```

Rq : restart du pods

<br>

* liste des tags d'images

```
fluxctl list-images
``` 

<br>

* pour un workload

```
fluxctl list-images --workload=default:deployment/hello-un
```

