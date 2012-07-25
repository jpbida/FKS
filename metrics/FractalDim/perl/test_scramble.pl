#!/usr/bin/perl

## Radius 1 sphere packing lattice 100x100x100 space ##
open(FH,"<test.dat");

@list = <FH>;

@list2=@list;
$outBND25="";
for($i=0;$i<(231*.25);$i++){
$rnd=int(rand($#list2));
$cord=$list2[$rnd];
chomp($cord);
splice(@list2,$rnd,1);
$outBND25.="$cord\t1\t2\n";
}

@list2=@list;
$outBND50="";
for($i=0;$i<(231*.5);$i++){
$rnd=int(rand($#list2));
$cord=$list2[$rnd];
chomp($cord);
splice(@list2,$rnd,1);
$outBND50.="$cord\t1\t2\n";
}

@list2=@list;
$outBND75="";
for($i=0;$i<(231*.75);$i++){
$rnd=int(rand($#list2));
$cord=$list2[$rnd];
chomp($cord);
splice(@list2,$rnd,1);
$outBND75.="$cord\t1\t2\n";
}

@list2=@list;
$outBND100="";
for($i=0;$i<231;$i++){
$rnd=int(rand($#list2));
$cord=$list2[$rnd];
chomp($cord);
splice(@list2,$rnd,1);
$outBND100.="$cord\t1\t2\n";
}

open(FH25,">test25.dat");
print FH25 "$outBND25";
open(FH25,">test50.dat");
print FH25 "$outBND50";
open(FH25,">test75.dat");
print FH25 "$outBND75";
open(FH25,">test100.dat");
print FH25 "$outBND100";




