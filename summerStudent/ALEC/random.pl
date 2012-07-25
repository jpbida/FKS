#!/usr/bin/perl
### Generates random positions for A and B with no boundaries in a 1000x1000 space ####
for($radius=0;$radius<10;$radius++){
$out="";
for($a=0; $a < 1000; $a++){
$x=rand(1000);
$y=rand(1000);
$z=rand(1000);
$out.="$x\t$y\t$z\t1\t0\n";
}
for($b=0; $b < 1000; $b++){
$x=rand(1000);
$y=rand(1000);
$z=rand(1000);
$out.="$x\t$y\t$z\t1\t1\n";
}
open(FH,">C$radius.dat");
print FH $out;
close(FH);
}
