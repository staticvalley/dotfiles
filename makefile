# app install script

all:
	sudo pacman -Syyu - < package_list.txt
	stow .
