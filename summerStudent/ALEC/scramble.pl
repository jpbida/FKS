#!/usr/bin/perl

## Radius 1 sphere packing lattice 100x100x100 space ##
open(FH,"<C1.dat");


## Creating data file for A = 1000, B = 1000, Ar=Br=1 C = 0 and Boundaries = 0% 25% 50% 75% and 99%

## total of 172,111 lattice positions ##
@list = <FH>;
## Pick random numbers between 1 and 172,111 to decide which positions each molecule will be placed ##

## Picks one random integer between 1 and 172111 ##
$outA="";
for($i=0;$i<1000;$i++){
$rnd=int(rand($#list));
$cord=$list[$rnd];
chomp($cord);
splice(@list,rnd,1);
if($i<999){
$outA.="$cord\t1\t0\n";
}else{
$outA.="$cord\t1\t0";
}
}

$outB="";
for($i=0;$i<1000;$i++){
$rnd=int(rand($#list));
$cord=$list[$rnd];
chomp($cord);
splice(@list,rnd,1);
if($i<999){
$outB.="$cord\t1\t1\n";
}else{
$outB.="$cord\t1\t1";

}
}

@list2=@list;
$outBND25="";
for($i=0;$i<42528;$i++){
$rnd=int(rand($#list));
$cord=$list[$rnd];
chomp($cord);
splice(@list,rnd,1);
$outBND25.="$cord\t1\t2\n";
}

@list=@list2;
$outBND50="";
for($i=0;$i<85056;$i++){
$rnd=int(rand($#list));
$cord=$list[$rnd];
chomp($cord);
splice(@list,rnd,1);
$outBND50.="$cord\t1\t2\n";
}

@list=@list2;
$outBND75="";
for($i=0;$i<127584;$i++){
$rnd=int(rand($#list));
$cord=$list[$rnd];
chomp($cord);
splice(@list,rnd,1);
$outBND75.="$cord\t1\t2\n";
}

@list=@list2;
$outBND100="";
for($i=0;$i<$#list2;$i++){
$rnd=int(rand($#list));
$cord=$list[$rnd];
chomp($cord);
splice(@list,rnd,1);
$outBND100.="$cord\t1\t2\n";
}


open(FH0,">c1_0.dat");
print FH0 "$outA\n$outB";
open(FH25,">c1_25.dat");
print FH25 "$outA\n$outB\n$outBND25";
open(FH50,">c1_50.dat");
print FH50 "$outA\n$outB\n$outBND50";
open(FH75,">c1_75.dat");
print FH75 "$outA\n$outB\n$outBND75";
open(FH100,">c1_100.dat");
print FH100 "$outA\n$outB\n$outBND100";




