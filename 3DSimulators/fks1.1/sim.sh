#!/bin/bash 
#PBS -l walltime=300:00:00,cput=300:00:00,ncpus=1
#PBS -j oe
#PBS -N outfile
./fks -f 1.00 -r 0.000000001 -o ./outfile -s 1000 -t 10 -E 1000 -S 1000 -C 0 -B 500000


