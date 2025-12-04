OBSIDIAN_DIR="/home/jaimedgp/Documents/Obsidian/Predictia"

function daily() {
    today=$(date +"%Y-%m-%d")
    vim "$OBSIDIAN_DIR/Agenda/daily/$today.md"
}

function tomorrow() {
    tomorrow=$(date -d "+1 day" +"%Y-%m-%d")
    vim "$OBSIDIAN_DIR/Agenda/daily/$tomorrow.md"
}
