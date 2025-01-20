# app install script

all:
	sudo pacman -Syyu --needed - < package_list.txt
	stow .
