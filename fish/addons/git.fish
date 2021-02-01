# git settings
abbr -a gl 'git log --graph --all --oneline --decorate'
abbr -a gpo 'git push origin'
abbr -a gst 'git status'

function ggpull
    git pull origin (git branch | grep \* | awk '{print $2}')
end
