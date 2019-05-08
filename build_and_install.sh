#!/bin/zsh

D_INSTALL_PATH=/opt/dmd
sudo mkdir -p ${D_INSTALL_PATH}/bin
sudo mkdir -p ${D_INSTALL_PATH}/lib
sudo mkdir -p ${D_INSTALL_PATH}/import

cd ~/code/D/SetupDDevelopmentEnvironment/

# dmd compiler
cd dmd/
make clean -f posix.mak
make -f posix.mak
sudo cp generated/**/dmd ${D_INSTALL_PATH}/bin/
cd ..

# druntime
cd druntime
make clean -f posix.mak
make -f posix.mak
sudo cp -r import/* ${D_INSTALL_PATH}/import/
cd ..

# phobos
cd phobos
make clean -f posix.mak
make -f posix.mak
sudo cp -r std/ ${D_INSTALL_PATH}/import/
sudo cp -r etc/* ${D_INSTALL_PATH}/import/etc/
sudo cp generated/**/libphobos2* ${D_INSTALL_PATH}/lib/
cd ..

# set import/library paths for dmd compiler
sudo cp dmd.conf ${D_INSTALL_PATH}/bin/

# gtkd
cd GtkD
make clean
sudo cp -r src/* ${D_INSTALL_PATH}/import/
make
sudo cp libgtkd-2.a ${D_INSTALL_PATH}/lib/
cd ..
