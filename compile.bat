nasm Sector1/bootloader.asm -f bin -o bootloader.bin

nasm Sector2/ExtendedProgram.asm -f bin -o ExtendedProgram.bin

copy /b bootloader.bin+ExtendedProgram.bin bootloader.flp

pause