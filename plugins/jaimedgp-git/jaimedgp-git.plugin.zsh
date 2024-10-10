alias ga="git add"
alias gs="git status"
alias gd="git diff"
alias gc="git commit -m"
alias gp="git push -u origin"
alias gr="git restore"
alias gchck="git checkout"
alias gnb="git checkout -b"


function gchbf() {
    branch=$(git branch | fzf --height 40% --reverse | awk '{print $1}')
    if [[ $branch != "" ]]; then
        if [[ $branch != "NAME" ]]; then
            git checkout $branch
        fi
    fi
}

function gdf() {
    file=$(git status --porcelain | grep '^ M' | sed s/^...// | fzf --height 40% --reverse)
    if [[ $file != "" ]]; then
        git diff $file
    fi
}

function grf() {
    file=$(git status --porcelain | grep '^ M' | sed s/^...// | fzf --height 40% --reverse)
    if [[ $file != "" ]]; then
        git restore $file
    fi
}
