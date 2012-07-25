#!/usr/bin/perl
open(FH,">>all.dat");
$out="";
for($x=0;$x<256;$x++){
print "$x\n";
	print FH $out;
	$out="";
for($y=0;$y<256;$y++){
for($z=0;$z<256;$z++){
	$out.="$x $y $z\n";
}
}
}
	print FH $out;
