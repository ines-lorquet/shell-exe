#!/bin/bash

# Chemin du fichier CSV
fichier_csv="/home/ines/shell.exe/job09/Shell_Userlist.csv"

while IFS=, read -r id prenom nom mdp role
do
    nom_utilisateur="${prenom,,}${nom,,}"
    mot_de_passe=$(mkpasswd -m sha-512 "$mdp")

#echo "$mot_de_passe"
    if id "$nom_utilisateur" &>/dev/null; then
            echo "L'utilisateur $nom_utilisateur existe déjà. Et son mdp est $mot_de_passe"

         else
         if useradd --badname -m -p "$mot_de_passe" "$nom_utilisateur"; then
            echo "L'utilisateur $nom_utilisateur a été créé avec le rôle $role.";


                if [ "$role" == "Admin" ]; then
                        usermod -aG sudo "$nom_utilisateur"
                        echo "Attribution des droits d'administrateur à $nom_utilisateur"
                fi
      else
          echo "Erreur lors de la création de l'utilisateur $nom_utilisateur."
        fi
    fi
done < "$fichier_csv"
