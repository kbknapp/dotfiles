function fzf_todoist_close
  todoist list | fzf | cut -d ' ' -f 1 | tr '\n' ' ' | sed -e 's/[ \t]*$//' | read ret 
  if [ $ret ]
    todoist close $ret
    commandline -f repaint
  end
end
function fzf_todoist_delete
  todoist list | fzf | cut -d ' ' -f 1 | tr '\n' ' ' | sed -e 's/[ \t]*$//' | read ret 
  if [ $ret ]
    todoist delete $ret
    commandline -f repaint
  end
end
function fzf_todoist_item
  todoist list | fzf | cut -d ' ' -f 1 | tr '\n' ' ' | read ret
  if [ $ret ]
    set buf (commandline | sed -e 's/[ \t]*$//')
    commandline "$buf $ret"
  end
end
function fzf_todoist_labels
  todoist labels | fzf | cut -d ' ' -f 1 | tr '\n' ',' | sed -e 's/,$//' | read ret
  if [ $ret ]
    set buf (commandline | sed -e 's/[ \t]*$//')
    commandline "$buf -L $ret"
  end
end
function fzf_todoist_project
  todoist projects | fzf | head -n1 | cut -d ' ' -f 1 | read ret
  if [ $ret ]
    set buf (commandline | sed -e 's/[ \t]*$//')
    commandline "$buf -P $ret"
  end
end

