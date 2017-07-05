# sp searches for projects
# opens them if one
# lists them if many
sp() {
	local OLD_IFS="$IFS"
	IFS=$'\n'

	# The space between the name of the file here is only
	# to be as fuzzy as spotlight (mdfind) cam
	files=($(mdfind "kMDItemAlternateNames == '$1*.sublime-project'"))

	if [ ${#files} -eq 0 ]; then
		echo $fg[red] "No project found";
	else
		if [ ${#files} -eq 1 ]; then
			subl "${files[1]}" --project
		else
			echo "$fg[red] ${#files} projects found";
			for i in "${files[@]}"
			do
				echo $fg[blue] $(basename $i)
				echo $fg[white] $i
			done
		fi
	fi

	IFS="$OLD_IFS"
	return 0
}

# same as above but opens the parent directory
spo(){
	local OLD_IFS="$IFS"
	IFS=$'\n'

	# The space between the name of the file here is only
	# to be as fuzzy as spotlight (mdfind) cam
	files=($(mdfind "kMDItemAlternateNames == '$1*.sublime-project'"))

	if [ ${#files} -eq 0 ]; then
		echo $fg[red] "No project found";
	else
		if [ ${#files} -eq 1 ]; then
			open $(dirname ${files[1]})
		else
			echo "$fg[red] ${#files} projects found";
			for i in "${files[@]}"
			do
				echo $fg[blue] $(basename $i)
				echo $fg[white] $i
			done
		fi
	fi
	
	IFS="$OLD_IFS"
	return 0	
}

# same as above but cd to the parent directory
spcd(){
	local OLD_IFS="$IFS"
	IFS=$'\n'
	
	# The space between the name of the file here is only
	# to be as fuzzy as spotlight (mdfind) cam
	files=($(mdfind "kMDItemAlternateNames == '$1*.sublime-project'"))

	if [ ${#files} -eq 0 ]; then
		echo $fg[red] "No project found";
	else
		if [ ${#files} -eq 1 ]; then
			cd $(dirname ${files[1]})
		else
			echo "$fg[red] ${#files} projects found";
			for i in "${files[@]}"
			do
				echo $fg[blue] $(basename $i)
				echo $fg[white] $i
			done
		fi
	fi
	
	IFS="$OLD_IFS"
	return 0	
}

# zsh completion for the `sp` and `spo` command
_subl_complete() {
	local OLD_IFS="$IFS"

	IFS=$'\n'

	# @todo : implement cache
	# if _cache_invalid sp_completion; then
		files=( $(mdfind "kMDItemAlternateNames == '$words[2]*.sublime-project'") )
		# _store_cache sp_completion files
	# else
		# files=_retrieve_cache
	# fi
	

	if [ "${#files}" -eq 0 ]; then
		echo "No project found";
	else
		if [ "${#files}" -eq 1 ]; then
			compadd $(basename "$files[1]" .sublime-project)
		else
			for i in "${files[@]}"
			do
				compadd $(basename "$i" .sublime-project)
			done
		fi
	fi

	IFS="$OLD_IFS"
	return 0
}
compdef "_subl_complete $@" sp spo spcd