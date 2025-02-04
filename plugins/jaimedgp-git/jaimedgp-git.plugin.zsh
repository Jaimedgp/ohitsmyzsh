alias ga="git add"
alias gs="git status"
alias gd="git diff"
alias gc="git commit -m"
alias gp="git push -u origin"
alias gr="git restore"
alias gchck="git checkout"
alias gnb="git checkout -b"

function gf() {
    projects_folder="$HOME/projects/"
    folder=$(find $projects_folder -type d -name ".git" -prune -exec dirname {} \; | sed "s|$projects_folder||" | fzf --height 40 --reverse)

    if [[ $folder != "" ]]; then
        cd $projects_folder$folder
    fi
}

function gpf() {
    branch=$(git branch | fzf --height 40% --reverse | awk '{print $1}')
    if [[ $branch != "" ]]; then
        if [[ $branch != "NAME" ]]; then
            echo $branch | xargs git push -u origin
        fi
    fi
}

function gbf() {
    branch=$(git branch | fzf --height 40% --reverse | awk '{print $1}')
    if [[ $branch != "" ]]; then
        if [[ $branch != "NAME" ]]; then
            git checkout $branch
        fi
    fi
}

function gdf() {
    file=$(git status --porcelain | grep '^ M' | sed s/^...// | fzf -m --height 40% --reverse)
    if [[ $file != "" ]]; then
        files=$(echo $file | tr '\n' ' ')
        echo $files | xargs git diff --
    fi
}

function grf() {
    cmd="git status --porcelain"
    grep=" | grep '.[M]'"
    staged=0

    while [[ $# -gt 0 ]]; do
        case "$1" in
            --staged)
                grep=" | grep '^M' "
                staged=1
                shift
                ;;
            *)
                echo "Unknown option: $1"
                echo "Usage: grf [--all] [--new]"
                return 1
                ;;
        esac
    done
    cmd+=$grep
    cmd+=" | sed s/^...// | fzf -m --height 40% --reverse | tr '\n' ' '"

    file=$(eval $cmd)

    if [[ $file != "" ]]; then
        if [[ $staged -eq 1 ]]; then
            echo $file | xargs git restore --staged
        else
            echo $file | xargs git restore
        fi
        echo "Files restored:"
        echo "$file" | tr '\n' '\n    - ' | awk '{print "    - " $0}'
    fi
}

function gaf() {
    cmd="git status --porcelain"

    if [[ $# -eq 0 ]]; then
        cmd+=" | grep '.[M]'"    # Loop through each argument
    fi

    while [[ $# -gt 0 ]]; do
        case "$1" in
            --all)
                cmd+=" | grep -v '^M' "
                shift
                ;;
            --new)
                cmd+=" | grep '^??' "
                shift
                ;;
            *)
                echo "Unknown option: $1"
                echo "Usage: gaf [--all] [--new]"
                return 1
                ;;
        esac
    done
    cmd+=" | sed s/^...// | fzf -m --height 40% --reverse | tr '\n' ' '"

    file=$(eval $cmd)  # | awk -F' -> ' '

    if [[ $file != "" ]]; then
        echo $file | xargs git add
        echo "Files added to Git:"
        echo "$file" | rev | sed 's/ //' | tr ' ' '\n    - ' | rev | awk '{print "    - " $0}'
    fi
}
