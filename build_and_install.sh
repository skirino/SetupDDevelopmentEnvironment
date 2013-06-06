#!/bin/zsh

D_INSTALL_PATH=/opt/dmd
sudo mkdir -p ${D_INSTALL_PATH}/bin
sudo mkdir -p ${D_INSTALL_PATH}/lib
sudo mkdir -p ${D_INSTALL_PATH}/import

cd ~/code/D/SetupDDevelopmentEnvironment/

# dmd compiler
cd dmd/src
make clean -f posix.mak
MODEL=`getconf LONG_BIT` make -f posix.mak dmd
sudo cp dmd ${D_INSTALL_PATH}/bin/
cd ../..

# druntime
cd druntime
make clean -f posix.mak
MODEL=`getconf LONG_BIT` make -f posix.mak
sudo cp -r import/* ${D_INSTALL_PATH}/import/
cd ..

# phobos
cd phobos
make clean -f posix.mak
MODEL=`getconf LONG_BIT` make -f posix.mak
sudo cp -r std/ ${D_INSTALL_PATH}/import/
sudo cp generated/**/libphobos2* ${D_INSTALL_PATH}/lib/
cd ..

# set import/library paths for dmd compiler
sudo cp ./dmd.conf ${D_INSTALL_PATH}/bin/

# gtkd
cd GtkD
make clean
make
sudo cp -r src/* ${D_INSTALL_PATH}/import/
sudo rm ${D_INSTALL_PATH}/import/**/*.o
sudo cp libgtkd-2.a ${D_INSTALL_PATH}/lib/
cd ..

