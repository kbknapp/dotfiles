# todoist
if type -q todoist ; and status --is-interactive
	source ~/.config/fish/functions/todoist.fish
end
if type -q todoist ; and type -q fzf; and status --is-interactive
	source ~/.config/fish/functions/fzf_todoist.fish
	alias tdi fzf_todoist_item
	alias tdp fzf_todoist_project
	alias tdl fzf_todoist_labels
	alias tdc fzf_todoist_close
	alias tdd fzf_todoist_delete
	alias todo get_rand_todos
end
