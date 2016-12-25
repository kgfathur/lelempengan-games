#!/bin/bash

intInput() {
	pos[$input]=$player
}

initMove() {
	tput cup 32 51
	echo "move"
}

main() {
	tput cup 31 0
	bacaInput=1;
	while [ $bacaInput == "1" ]
	do
	echo "games : player $player, $pertama main"
	read -d'' -s -n1 input  # read input
	case $input in
	[1-9])
		bacaInput=0; ;;
	*)
		tput cup 31 0 ;;
	esac
	done

	tput cup 32 27
	if [ -z ${pos[$input]} ]; then
		ignore="0"
		case $input in
			7)
				row="2"
				col="3"
				if [ $((pion[player])) != "3" ]; then
					intInput;
				else
					initMove $input $row $col;
				fi
				;;
			8)
				row="2"
				col="27"
				if [ $((pion[player])) != "3" ]; then
					intInput;
				else
					initMove $input $row $col;
				fi
				;;
			9)
				row="2"
				col="51"
				if [ $((pion[player])) != "3" ]; then
					intInput;
				else
					initMove $input $row $col;
				fi
				;;
			4)
				row="14"
				col="3"
				if [ $((pion[player])) != "3" ]; then
					intInput;
				else
					initMove $input $row $col;
				fi
				;;
			5)
				row="14"
				col="27"
				if [ $((pion[player])) != "3" ]; then
					intInput;
				else
					initMove $input $row $col;
				fi
				;;
			6)
				row="14"
				col="51"
				if [ $((pion[player])) != "3" ]; then
					intInput;
				else
					initMove $input $row $col;
				fi
				;;
			1)
				row="26"
				col="3"
				if [ $((pion[player])) != "3" ]; then
					intInput;
				else
					initMove $input $row $col;
				fi
				;;
			2)
				row="26"
				col="27"
				if [ $((pion[player])) != "3" ]; then
					intInput;
				else
					initMove $input $row $col;
				fi
				;;
			3)
				row="26"
				col="51"
				if [ $((pion[player])) != "3" ]; then
					intInput;
				else
					initMove $input $row $col;
				fi
				;;
			*)
				ignore="1"
				;;
		esac
	
		if [ "$ignore" != "1" ]; then
				if [ $((pion[player])) != "3" ]; then
					tulis $play $row $col;
					pion[player]=$((pion[player]+1))
				fi

			tput cup 32 27
			echo "pion1 = ${pion[1]} pion2 = ${pion[2]}"
			gantiMain=1;
		fi
		cek_pemenang;
	else
		gantiMain=0;
		echo "sudah ada"
	fi
}

initPlayer() {
	if [ $gantiMain == "1" ]; then
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
	fi
}

tulis() {
	r=$2
	c=$3
	tput bold
	if [ $1 == "man1" ]; then
		echo -e "\e[48;5;9m\e[38;5;231m"
	elif [ $1 == "man2" ]; then
		echo -e "\e[48;5;21m\e[38;5;231m"
	fi

	awk 'BEGIN {b='$r'; c='$c';}
	{
		system("tput cup " b " " c)
		print
		b+=1
	}' $play

	echo -e "\033[0m"
	tput sgr0
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

layout() {
	tput bold
	echo -ne "\e[48;5;220m\e[38;5;28m"
	awk '{print}' layout1
	echo -e "\e[48;5;221m"
	awk 'BEGIN {
		for(i=2; i<5; i++) {
			for(j=3; j<58; j+=24) {
				system("tput cup " i " " j)
				printf "       "
				system("tput cup " i+12 " " j)
				printf "       "
				system("tput cup " i+24 " " j)
				printf "       "
			}
		}
	}'
	tput sgr0
	echo -e "\033[0m"
}
####################################################################
opening() {
zenity --question --width="600" --height="100" \
--title 'Game Kaulinan Budak Sunda Baheula - Lelempengan' \
--ok-label="Langsung Main =>" --cancel-label="Tidak Jadi Main" \
--text \
'<span foreground="green" size="xx-large"><b>Rules of The Game is :</b></span>
<span size="large">	1. Dimainkan Oleh 2 Orang Pemain
	2. Seorang Pemain Hanya Mempunyai 3 Pion
	3. Pemenangnya Adalah Pemain Yang Pertama
	    Membentuk Garis Lurus dari Ketiga Pionnya,
	    Bisa Lurus Satu Baris, Kolom, atau Diagonal
	4. Yang Pertama Bermain, Mungkin Anda Beruntung</span>'

if [ $? == 1 ]; then
	clear
	exit;
else
	load_pemain;
fi
}
####################################################################
load_pemain() {
loop=1;
while [ $loop == "1" ]; do
	loop=0
	pemain=$(zenity --forms --title="Lelempengan's The Game" \
		--text="Masukkan Identitas Pemain : " \
		--separator=":" \
		--add-entry="Nama Pemain-1" \
		--add-entry="Nama Pemain-2");
	maju=$?
	name1=$(awk -F: '{print $1}' <<<$pemain)
	name2=$(awk -F: '{print $2}' <<<$pemain)
	if [ $maju == "1" ]; then
		opening;
	elif [[ ($maju == "0") && (( ! -z $name1) || ( ! -z $name2)) ]]; then
		
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
				echo "100" ; echo "# $pertama main duluan" ; sleep  1
				) |
				zenity --progress  --width="350" --height="100" --no-cancel --timeout 1 --title "Acak Pemain Pertama" \
				--text "Siapa duluan ya..." --percentage=0
	elif [[ (-z $name1) || (-z $name2) ]]; then
		loop=1;
	fi
done
}
####################################################################

wmctrl -r :ACTIVE: -b add,maximized_vert
wmctrl -r :ACTIVE: -e 0,397,0,572,-1

zenity --warning --width="550" --height="100" --title "Harap Diperhatikan Sebelum Main" \
--text='<span size="large">Games ini membutuhkan pakcage <b>wmctrl</b>. Silahkan install
package <b>wmctrl</b> dengan :
	<b>sudo apt-get install wmctrl</b> (online)
atau apabila tidak mau menginstall package tersebut,
<b>MAXIMIZE</b> terlebih dahulu terminal sebelum menjalankan
program game ini agar tampilan tidak error</span>'

pion[1]=0;
pion[2]=0;
opening;
clear
layout;
gantiMain=1;
while true
do
	main;
	initPlayer;
done
