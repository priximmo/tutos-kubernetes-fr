%title: KUBERNETES
%author: xavki
%Vidéos: [Formation Kubernetes](https://www.youtube.com/playlist?list=PLn6POgpklwWqfzaosSgX2XEKpse5VY2v5)
%blog: [Xavki Blog](https://xavki.blog)



# TOOLS : Prompt & Alias


<br>

https://github.com/jonmosco/kube-ps1

--------------------------------------------------------------

# TOOLS : Prompt & Alias


<br>

```
alias k='kubectl'
alias kd='kubectl describe'
alias kcc='kubectl config current-context'
alias kg='kubectl get'
alias kga='kubectl get all --all-namespaces'
alias kgp='kubectl get pods'
alias kgs='kubectl get services'
alias ksgp='kubectl get pods -n kube-system'
alias kss='kubectl get services -n kube-system'
alias kuc='kubectl config use-context'
alias kx='kubectx'
alias kn='kubens'
alias h='helm'
source <(helm completion bash)
complete -o default -F __start_helm h
source <(kubectl completion bash)
complete -F __start_kubectl k
```
