# Fzf
#if [ -e /usr/share/fish/functions/fzf_key_bindings.fish ]; and status --is-interactive
#	source /usr/share/fish/functions/fzf_key_bindings.fish
#end
setenv FZF_FIND_FILE_COMMAND 'fd --type file --follow'
setenv FZF_CTRL_T_COMMAND 'fd --type file --follow'
setenv FZF_DEFAULT_OPTS '--height 20%'
