# JuiceBoxOS
Welcome! This is a public repo containing my source code for JuiceBoxOS. The goal of this project is to understand how operating system works from interrupts to filesystems. For now, this is a simple 32bit kernel that prints characters.
# JuiceBoxOS Requirements

## Recommended Setups and Required Dependencies
- Recommended Operating System to develop on: Ubuntu
- Required Dependencies:
  - build-essential
  - bison
  - flex
  - libgmp3-dev
  - libmpc-dev
  - libmpfr-dev
  - texinfo
  - libisl-dev

### Command to install the dependencies on Ubuntu
```
sudo apt install build-essential bison flex libgmp3-dev libmpc-dev libmpfr-dev texinfo libisl-dev
```

## Installing Cross Compiler
To compile the operating system, please run i686_cross_compiler_installer.sh to install the required cross compiler.
```
./i686_cross_compiler_installer.sh
```

## Compiling and Running JuiceBoxOS
Then, run compile.sh to make a .iso of the OS and also run the .iso using qemu.
```
./compile.sh
```

# To-Do List:
- implement terminal scrolling
- implement GDT
- implement interrupts
- implement shell
- implement a custom bootloader

# Final Remarks
Thank you for looking at JuiceBoxOS. Feel free to reach out at steven.frausto@nachoweb.tech as I do appreciate feedback and advices!
