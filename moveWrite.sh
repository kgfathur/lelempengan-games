#!/bin/bash

main() {
	tput cup 31 0
	echo "games : player $player, $pertama main"
	read -d'' -s -n1 input  # read input
	
	tput cup 32 51
	if [ -z ${pos[$input]} ]; then
		ignore="0"
		case $input in
			7)
				row="2"
				col="3"
				pos[$input]=$player
				;;
			8)
				row="2"
				col="27"
				pos[$input]=$player
				;;
			9)
				row="2"
				col="51"
				pos[$input]=$player
				;;
			4)
				row="14"
				col="3"
				pos[$input]=$player
				;;
			5)
				row="14"
				col="27"
				pos[$input]=$player
				;;
			6)
				row="14"
				col="51"
				pos[$input]=$player
				;;
			1)
				row="26"
				col="3"
				pos[$input]=$player
				;;
			2)
				row="26"
				col="27"
				pos[$input]=$player
				;;
			3)
				row="26"
				col="51"
				pos[$input]=$player
				;;
			*)
				ignore="1"
				;;
		esac
	
		if [ "$ignore" != "1" ]; then
			tulis $play $row $col;
		fi
		cek_pemenang;
	else
		echo "sudah ada"
	fi
}

initPlayer() {
	if [ "$player" == 1 ]
	then
		player=2;
		pertama=$name2
		play="man2"
	else
		player=1;
		pertama=$name1
		play="man1"
	fi
}

tulis() {
	r=$2
	c=$3
	if [ $1 == "man1" ]; then
		echo -e "\033[44m"
	elif [ $1 == "man2" ]; then
		echo -e "\033[43m"
	fi

	awk 'BEGIN {b='$r'; c='$c';}
	{
		system("tput cup " b " " c)
		print
		b+=1
	}' $play

	echo -e "\033[0m"
	tput cup 31 0
}

winner() {
	tput cup 33 0
	echo "Pemenang adalah player $1"
	tput cup 31 0
}

cek_pemenang() {
	nilai=1;
	x=0;
	for i in `cat pattern`; do
		x=$((x+1));
		nilai=$((nilai*pos[i]))
		#echo "nilai-$i = $nilai"
		if [ $x == "3" ]; then
			case $nilai in
				1) winner 1;
					zenity --info --text "Mantaaap!!! $name1 Menang"
					clear
					exit;
				;;
				8) winner 2;
					zenity --info --text "Mantaaap!!! $name2 Menang"
					clear
					exit;
				;;
			esac
			nilai=1;
			x=0;
		fi
	done
}

####################################################################
opening() {
zenity --question --width="500" --height="100" \
--title "Game Kaulinan Budak Sunda Baheula - Lelempengan" \
--ok-label="Langsung Main =>" --cancel-label="Tidak Jadi Main" \
--text \
"<span size=\"xx-large\">Rules of The Game is :</span>
<span size=\"large\">	1. Dimainkan Oleh 2 Orang Pemain
	2. Seorang Pemain Hanya Mempunya 3 Pion
	3. Pemenangnya Adalah Pemain Yang Pertama
	    Membentuk Garis Lurus dari Ketiga Pionnya,
	    Bisa Lurus Satu Baris, Kolom, atau Diagonal
	4. Yang Pertama Bermain, Mungkin Anda Beruntung</span>"

if [ $? == 1 ]; then
	clear
	exit;
else
	load_pemain;
fi
}
####################################################################
load_pemain() {
while [[ (-z $name1) || (-z $name2) ]]; do
	pemain=$(zenity --forms --title="Lelempengan's The Game" \
		--text="Masukkan Identitas Pemain : " \
		--separator=":" \
		--add-entry="Nama Pemain-1" \
		--add-entry="Nama Pemain-2");
	maju=$?
	name1=$(awk -F: '{print $1}' <<<$pemain)
	name2=$(awk -F: '{print $2}' <<<$pemain)
	done
	case $maju in
			0)
				player=$((( RANDOM % 2 ) + 1 ));
				case $player in
					1) play="man1" pertama=$name1;;
					2) play="man2" pertama=$name2;;
				esac
				(
				echo "5" ; sleep 1.5; echo "# mending $name1 dulu" ; sleep 0.7;
				echo "10" ; echo "# atau $name2 aja" ; sleep  0.7
				echo "20" ; echo "# $name1 dulu deh" ; sleep  0.7
				echo "45" ; echo "# eh $name2 lebih cakep" ; sleep  0.7
				echo "65" ; echo "# tapi $name1 baik" ; sleep  0.5
				echo "80" ; echo "# $name2 juga sih" ; sleep  0.5
				echo "90" ; echo "# pilih $name1 atau $name2 ya" ; sleep  0.6
				echo "100" ; echo "# $pertama Main Duluan" ; sleep  1
				) |
				zenity --progress --no-cancel --timeout 7 --title "Acak Pemain Pertama" \
				--text "Siapa duluan ya..." --percentage=0
					;;
			1)
				exit;					
					;;
			-1)
			    echo "Terjadi Error!" ;;
	esac
}
####################################################################
opening;

clear
while true
do
	main;
	initPlayer;
done
