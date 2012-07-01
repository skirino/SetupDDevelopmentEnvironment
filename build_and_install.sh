#!/bin/zsh

D_INSTALL_PATH=/opt/dmd
sudo mkdir -p ${D_INSTALL_PATH}/bin
sudo mkdir -p ${D_INSTALL_PATH}/lib
sudo mkdir -p ${D_INSTALL_PATH}/import

cd ~/code/D/SetupDDevelopmentEnvironment/
git submodule init
git submodule update

# dmd compiler
cd dmd/src
cat posix.mak | sed -e s/MODEL=32/MODEL\?=32/ > posix_mod.mak
MODEL=`getconf LONG_BIT` make -f posix_mod.mak dmd
sleep 5
rm posix_mod.mak
sudo cp dmd ${D_INSTALL_PATH}/bin/
cd ../..

# druntime
cd druntime
MODEL=`getconf LONG_BIT` make -f posix.mak
sudo cp -r import/* ${D_INSTALL_PATH}/import/
cd ..

# phobos
cd phobos
MODEL=`getconf LONG_BIT` make -f posix.mak
sudo cp -r std/ ${D_INSTALL_PATH}/import/
sudo cp generated/**/libphobos2.a ${D_INSTALL_PATH}/lib/
cd ..

# set import/library paths for dmd compiler
sudo cp ./dmd.conf ${D_INSTALL_PATH}/bin/

# gtkd
cd GtkD
make
sudo cp -r src/* ${D_INSTALL_PATH}/import/
sudo rm ${D_INSTALL_PATH}/import/dsss.conf
sudo cp libgtkd.a ${D_INSTALL_PATH}/lib/
cd ..

