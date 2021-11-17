#! /bin/bash

FILES=/src/target/share/riscv-tests/benchmarks/dhrystone.riscv
SAVE_DIR=/src/chisel-template/src/riscv

for f in $FILES
do
    FILE_NAME="dhrystone.riscv"
    if [[ ! $f =~ "dump" ]]; then
        riscv64-unknown-elf-objcopy -O binary $f $SAVE_DIR/$FILE_NAME.bin
        od -An -tx4 -w4 -v $SAVE_DIR/$FILE_NAME.bin > $SAVE_DIR/$FILE_NAME.hex
        rm -f $SAVE_DIR/$FILE_NAME.bin
    fi
done