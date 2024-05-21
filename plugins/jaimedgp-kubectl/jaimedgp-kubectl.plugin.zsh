if (( ! $+commands[kubectl] )); then
  return
fi

# If the completion file doesn't exist yet, we need to autoload it and
# bind it to `kubectl`. Otherwise, compinit will have already done that.
if [[ ! -f "$ZSH_CACHE_DIR/completions/_kubectl" ]]; then
  typeset -g -A _comps
  autoload -Uz _kubectl
  _comps[kubectl]=_kubectl
fi

kubectl completion zsh 2> /dev/null >| "$ZSH_CACHE_DIR/completions/_kubectl" &|

# This command is used a LOT both below and in daily life
alias k=kubectl

# Contexts Manage
alias kcuc='kubectl config use-context'
alias kccc='kubectl config current-context'
alias kcgc='kubectl config get-contexts'


# Namespaces management
alias kgn="kubectl get namespace"


# Deployments management
alias kgd="kubectl get deployments"


# Services management
alias kgs="kubectl get services"


# Pods management.
alias kgp='kubectl get pods'
alias kgpa='kubectl get pods --all-namespaces'


alias kpf="kubectl port-forward"  # Port forwarding
alias kcp='kubectl cp'            # File copy

#---------------------------------------------------------------------------

alias k3="sudo k3s kubectl"
# Contexts Manage
alias k3cuc='sudo k3s ubectl config use-context'
alias k3ccc='sudo k3s ubectl config current-context'
alias k3cgc='sudo k3s ubectl config get-contexts'


# Namespaces management
alias k3gn="sudo k3s kubectl get namespace"


# Deployments management
alias k3gd="sudo k3s kubectl get deployments"


# Services management
alias k3gs="sudo k3s kubectl get services"


# Pods management.
alias k3gp='sudo k3s kubectl get pods'
alias k3gpa='sudo k3s kubectl get pods --all-namespaces'


alias k3pf="sudo k3s ubectl port-forward"  # Port forwarding
alias k3cp='sudo k3s ubectl cp'            # File copy
