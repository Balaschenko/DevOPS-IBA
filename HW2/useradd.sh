#!/bin/bash

#Sozdanie polzovatel'ya. Esli on suschestvuet, to vyity


echo -n "Vvedite username: "
read USER

if id $USER >/dev/null 2>&1
then
	echo "USER \"$USER\" exists!" && exit 1
else
	useradd -m -d /home/$USER $USER && echo "USER \"$USER\" created!"
fi

