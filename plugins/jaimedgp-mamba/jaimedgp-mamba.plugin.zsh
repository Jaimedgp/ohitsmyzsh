function ma() {
    env=$(mamba env list | fzf --height 40% --reverse | awk '{print $1}')
    echo $env | xargs mamba activate

}
