function clean_and_display
	begin
		set -l IFS
		set out (echo $argv |\
			column |\
			grep --color=never -Po '(?<=#).*' |\
			sed 's/@[^ ]*//' |\
			sed 's/ \+/ /g' |\
			awk '{printf "\t* %s  -- ", $1; $1=""; print $0}') 
		set len (echo $out | wc -l)
		if [ $len -gt 5 ]
			echo (echo $out | head -n5)
			echo "..."
		else
			echo $out
		end
	end
end

function get_rand_todos
	todoist sync
	set_color normal
	echo -e " \e[1mTODOs\e[0;32m"
	echo
	set r (random 0 100)
	begin
		set -l IFS

		if [ $r -lt 5 ] # only occasionally show backlog (5%)
			echo -e " \e[1mBacklog\e[0;32m"
			set_color blue
			set backlog (todoist list -f 'overdue & (p1 | @onhold) & !@GCal')
			clean_and_display $backlog
		end

		if [ $r -lt 10 ]
			# unimportant, so show rarely
			set_color cyan
			set low (todoist list -f 'p1 & !(@GCal | @onhold | overdue)')
			clean_and_display $low
		end
		if [ $r -lt 25 ]
			# back-of-my-mind, so show occasionally
			set_color green
			set med (todoist list -f 'p2 & !(@GCal | @onhold | overdue)')
			clean_and_display $med
		end
		if [ $r -lt 50 ]
			# upcoming, so prompt regularly
			set_color yellow
			set high (todoist list -f 'p3 & !(@GCal | @onhold | overdue)')
			clean_and_display $high
		end

		# urgent, so prompt always
		set_color red
			set urgent (todoist list -f '(p4 | today | overdue) & !(@GCal | @onhold)')
			clean_and_display $urgent
		echo
	end

	set_color normal
end
