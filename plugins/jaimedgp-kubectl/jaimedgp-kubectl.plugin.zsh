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
