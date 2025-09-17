#!/bin/bash
#This bash script is created by Sir Nacho in 7/16/2025

# This is a script that automates the creation of the i686 gcc cross compiler. 
# NOTE: This is a general install so developing JukeBoxOS with this specific cross compiler
# will require be developed on X86 machines. Do note I am working on adding ARM dev support
# in the future since I do use macs every now and then (even though those machines are overrated
# and overpriced but I digress...). Also, due to the variety of different OS used to develop,
# I'll make a seperate bash script for installing the dependencies used (except Windows) - Sir Nacho

PURPLE='\e[0;35m' #ANSI, my beloved. -SN
GREEN='\033[0;32m'
RED='\033[0;31m'

#Title of script:
TITLE='CROSS COMPILER INSTALLER'

#echo -e "${PURPLE}[${TITLE}] - This is purple."
#echo -e "${GREEN}[${TITLE}] - This is green."
#echo -e "${RED}[${TITLE}] - This is red."

#NOTE: There is a better way to handle the coloring and title, but for now, I leave as is. -SN

echo -e "${PURPLE}[${TITLE}] - Making and cd-ing ~/src directory..."

mkdir ~/src
cd ~/src

echo -e "${PURPLE}[${TITLE}] - Exporting variables needed for GCC..."

export PREFIX="$HOME/opt/cross"
export TARGET=i686-elf
export PATH="$PREFIX/bin:$PATH"

echo -e "${PURPLE}[${TITLE}] - Downloading required files..."
echo -e "${PURPLE}[${TITLE}] - Downloading Binutils..."

git clone git://sourceware.org/git/binutils-gdb.git

echo -e "${PURPLE}[${TITLE}] - Downloading GDB..."

wget https://ftp.gnu.org/gnu/gdb/gdb-16.3.tar.xz

echo -e "${PURPLE}[${TITLE}] - Downloading GCC..."

wget https://ftp.gnu.org/gnu/gcc/gcc-15.1.0/gcc-15.1.0.tar.gz

echo -e "${PURPLE}[${TITLE}] - Extracting the tar.gz..."

tar -xvzf gcc-15.1.0.tar.gz
tar -xvzf gdb-16.3.tar.gz

echo -e "${PURPLE}[${TITLE}] - Making Binutils..."

mkdir build-binutils
cd build-binutils
../binutils-gdb/configure --target=$TARGET --prefix="$PREFIX" --with-sysroot --disable-nls --disable-werror
make
make install

echo -e "${PURPLE}[${TITLE}] - Making GDB..."

../gdb.16.3/configure --target=$TARGET --prefix="$PREFIX" --disable-werror
make all-gdb
make install-gdb

echo -e "${PURPLE}[${TITLE}] - Making GCC..."

cd ~/src

which -- $TARGET-as || echo $TARGET-as is not in the PATH

mkdir build-gcc && cd build-gcc
../gcc-15.1.0/configure --target=$TARGET --prefix="$PREFIX" --disable-nls --enable-languages=c,c++ --without-headers --disable-hosted-libstdcxx

#Note: making the build faster by parallelzing it -SN

make -j 8 all-gcc
make -j 8 all-target-libgcc
make -j 8 all-target-libstdc++-v3
make -j 8 install-gcc
make -j 8 install-target-libgcc
make -j 8 install-target-libstdc++-v3

echo -e "${PURPLE}[${TITLE}] - Outputting newly built gcc version..."
$HOME/opt/cross/bin/$TARGET-gcc --version

echo -e "${PURPLE}[${TITLE}] - Exporting the new gcc to the path..."
export PATH="$HOME/opt/cross/bin:$PATH"

echo -e "${GREEN}[${TITLE}] - All set for some osDev!!!"
