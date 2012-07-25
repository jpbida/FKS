#!/bin/bash 

params="-E 0 -e 0 -S 0 -a 0 -C 0 -b 0 -B 0"
./fks -f 1 -r 0.02 -o tmp -s 102 -t 1000  -T 1 -i input.dat -O 2 $params 

