fish_vi_key_bindings

alias vim='nvim'

# git settings
abbr gl 'git log --graph --all --oneline --decorate'
abbr gpo 'git push origin'
abbr gst 'git status'

# Exa
abbr ls 'exa'
abbr tree 'exa -T'

abbr mkdir 'mkdir -pv'

function ggpull
    git pull origin (git branch | grep \* | awk '{print $2}')
end
