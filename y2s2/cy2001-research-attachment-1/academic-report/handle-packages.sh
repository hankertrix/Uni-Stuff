#!/bin/sh

PACKAGES='
jupyter-notebook
python-pandas
python-numpy
python-matplotlib
python-scipy
python-seaborn
python-scikit-learn
python-setuptools
python-ahrs
'

case $1 in

i | install)
	paru -S --needed $PACKAGES
	;;
u | uninstall | r | remove)
	paru -Rns $PACKAGES
	;;
esac
