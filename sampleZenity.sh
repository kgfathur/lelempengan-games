#!/bin/bash

############# FORM INPUT
satu() {
	zenity --forms --title "Select Flash Drives" \
	--text  "Select Flash Drives" \
	--add-list "Insert your choice" --list-values 'a|b|c' \
	--add-entry="IP address" --add-entry="PORT"
}

############# PARSE MULTIPLE INPUT
dua() {
	pemain=$(zenity --forms --title="Lelempengan's The Game" \
		--text="Masukkan Identitas Pemain : " \
		--separator=":" \
		--add-entry="Nama Pemain-1" \
		--add-entry="Nama Pemain-2");
	case $? in
			0)
					pemain;
					;;
			1)
					exit;;
			-1)
			    echo "Terjadi Error!" ;;
	esac
}
pemain() {
	name1=$(awk -F: '{print $1}' <<<$pemain)
	name2=$(awk -F: '{print $2}' <<<$pemain)
	while [[ (-z $name1) || (-z $name2) ]]; do
		dua;
	done
}

############## CUSTOM VIEW
tiga() {
	zenity --info --timeout 3 \
	--text="<span size=\"xx-large\">Time is $(date +%Hh%M).</span>\n\nGet your <b>coffee</b>." \
	--title="Coffee time" \
	--ok-label="Sip"
}
dua;
echo "$name1"
echo "$name2"
