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

function kc() {
    context=$(kubectl config get-contexts | fzf --height 40% --reverse | awk '{print $1}')
    if [[ $context == "*" ]]; then
        kubectl config current-context | awk '{print "You are currently using context: " $1}'
    else
        if [[ $context == "CURRENT" ]]; then
            echo "Invalid context selected"
            kubectl config current-context | awk '{print "Back to the currently using context: " $1}'
        else
            if [[ $context != "" ]]; then
                kubectl config use-context $context
            fi
        fi
    fi
}


# Namespaces management
alias kgn="kubectl get namespace"


# Deployments management
alias kgd="kubectl get deployments"


# Services management
alias kgs="kubectl get services"


# Pods management.
alias kgp='kubectl get pods'
alias kgpa='kubectl get pods --all-namespaces'
alias kdp="kubectl delete pods -i"

function kdpf() {
    pod=$(kubectl get pods | fzf -m --height 40% --reverse | awk '{print $1}')
    if [[ $pod != "" ]]; then
        if [[ $pod != "NAME" ]]; then
            kubectl delete pods -i $pod
        fi
    fi
}


# Jobs management
alias kgj="kubectl get jobs"
alias kdj="kubectl delete jobs -i"
function kdjf() {
    job=$(kubectl get jobs | fzf -m --height 40% --reverse | awk '{print $1}')
    if [[ $job != "" ]]; then
        if [[ $job != "NAME" ]]; then
            kubectl delete jobs -i $job
        fi
    fi
}


alias kpf="kubectl port-forward"  # Port forwarding
alias kcp='kubectl cp'            # File copy

alias kl="kubectl logs"
function klf() {
    pod=$(kubectl get pods | fzf --height 40% --reverse | awk '{print $1}')
    if [[ $pod != "" ]]; then
        if [[ $pod != "NAME" ]]; then
            kubectl logs $pod
        fi
    fi
}

function klft() {
    pod=$(kubectl get pods | fzf --height 40% --reverse | awk '{print $1}')
    if [[ $pod != "" ]]; then
        if [[ $pod != "NAME" ]]; then
            kubectl logs $pod > /tmp/logs_$pod.txt
        fi
    fi

    if [[ -f /tmp/logs_$pod.txt ]]; then
        cat /tmp/logs_$pod.txt | fzf
    fi
}

function kex() {
    term=/bin/bash
    while [[ $# -gt 0 ]]; do
        case "$1" in
            --zsh)
                term=/bin/zsh
                shift
                ;;
            --bash)
                term=/bin/bash
                shift
                ;;
            *)
                echo "Unknown option: $1"
                echo "Usage: gaf [--all] [--new]"
                return 1
                ;;
        esac
    done

    pod=$(kubectl get pods | fzf --height 40% --reverse | awk '{print $1}')
    if [[ $pod != "" ]]; then
        if [[ $pod != "NAME" ]]; then
            kubectl exec -ti $pod -- $term
        fi
    fi
}

#---------------------------------------------------------------------------

alias k3="sudo k3s kubectl"
# Contexts Manage
alias k3cuc='sudo k3s kubectl config use-context'
alias k3ccc='sudo k3s kubectl config current-context'
alias k3cgc='sudo k3s kubectl config get-contexts'


# Namespaces management
alias k3gn="sudo k3s kubectl get namespace"


# Deployments management
alias k3gd="sudo k3s kubectl get deployments"


# Services management
alias k3gs="sudo k3s kubectl get services"


# Pods management.
alias k3gp='sudo k3s kubectl get pods'
alias k3gpa='sudo k3s kubectl get pods --all-namespaces'


alias k3pf="sudo k3s kubectl port-forward"  # Port forwarding
alias k3cp='sudo k3s kubectl cp'            # File copy

