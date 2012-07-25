#!/bin/bash 
#PBS -l walltime=300:00:00,cput=300:00:00,ncpus=1
#PBS -j oe
#PBS -N outfile
./fks -f 1.00 -r 0.02 -o outfile -s 100 -t 1000 -E 10 -S 40 -C 0 -B 0
mv debug.csv debug1.csv
./fks -f 1.00 -r 0.02 -o outfile -s 100 -t 1000 -E 10 -S 40 -C 0 -B 20
mv debug.csv debug2.csv
./fks -f 1.00 -r 0.02 -o outfile -s 100 -t 1000 -E 10 -S 40 -C 0 -B 40
mv debug.csv debug3.csv
./fks -f 1.00 -r 0.02 -o outfile -s 100 -t 1000 -E 10 -S 40 -C 0 -B 60
mv debug.csv debug4.csv

