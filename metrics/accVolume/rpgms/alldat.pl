#!/usr/bin/perl
open(FH,">>all2d_512");
$out="";
for($x=0;$x<512;$x++){
print "$x\n";
	print FH $out;
	$out="";
for($y=0;$y<512;$y++){
	$out.="$x $y 0\n";
}
}
	print FH $out;

	open(FH,">>all2d_1024");
$out="";
for($x=0;$x<1024;$x++){
print "$x\n";
	print FH $out;
	$out="";
for($y=0;$y<1024;$y++){
	$out.="$x $y 0\n";
}
}
	print FH $out;
