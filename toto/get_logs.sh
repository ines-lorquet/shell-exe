nb_connexions=$(last | grep -c "$utilisateur" | journalctl -b | grep "session opened" | wc -l)
utilisateur="ines"
date=$(date +'%d-%m-%Y-%H-%M')
sortie="number_connection-$date"
echo "$nb_connexions" > "$sortie"
#echo "$sortie"
tar -cvf /home/ines/shell.exe/job08/Backup/$sortie.tar $sortie
echo "le nombre de co est de" "$nb_connexions"
rm $sortie
