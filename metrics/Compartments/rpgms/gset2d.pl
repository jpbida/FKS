#!/usr/bin/perl
sub genset{
my $f1=shift(@_);
my $f2=shift(@_);
open(F1,"<$f1");	
my @pixs=<F1>;
close(F1);
my $out = `wc -l $f1`;
my @o = split(/[\ ]+/,$out);
my $lines1=$o[1];
my($x,$y,$z);
print "$lines1\n";
my $i=0;
my $opix="";
foreach  $pix (@pixs){
$i++;
$opix.=$pix;
	my @num=split(/\ /,$pix);
if($#num==6){
if($num[0]==2){$x=$num[4]-1;$y=$num[5];$z=$num[6];$opix.="9 9 9 9 $x $y $z\n";}
if($num[1]==2){$x=$num[4];$y=$num[5]-1;$z=$num[6];$opix.="9 9 9 9 $x $y $z\n";}
if($num[2]==2){$x=$num[4]+1;$y=$num[5];$z=$num[6];$opix.="9 9 9 9 $x $y $z\n";}
if($num[3]==2){$x=$num[4];$y=$num[5]+1;$z=$num[6];$opix.="9 9 9 9 $x $y $z\n";}
}
}
chomp($opix);
print "$i:$lines1\n";
open(F1,">tmpB.px");
print F1 $opix;
close(F1);
my $cmd="cat tmpB.px $f2 | sort -t ".'" "'. " -k 5 | uniq -d -f 5 > $f1";
system("$cmd");

$out = `wc -l $f1`;
@o = split(/[\ ]+/,$out);
$lines2=$o[1];
if($lines2 > $lines1){
	genset($f1,$f2);
}else{
	print "Returned: $lines2\n";
	return($lines2);
}

}

### Run over all pixels in a file ####
$file=$ARGV[0];
@datasets=("$file");
foreach $dataset (@datasets){
system("cp $dataset $dataset\_bkup");
$out = `wc -l $dataset`;
@o = split(/[\ ]+/,$out);
my $l2=$o[1];
print "Number of Lines in $dataset: $l2\n";

open(FH,">t1_gs.x");
open(FI,"<$dataset");
@all=<FI>;
print FH "$all[1]\n";
print "$all[1]\n";
close(FI);
close(FH);



$j=0;
while($l2 > 0){
$t<-genset("t1_gs.x",$dataset);
$out = `wc -l t1_gs.x`;
@o = split(/[\ ]+/,$out);
$l2=$o[1];
system("sed '/^[ ]*\$/d' t1_gs.x > tt");
system("mv tt t1_gs.x");
system("awk '{print $j,\$5,\$6,\$7}' t1_gs.x > tt");
system("cat tt $dataset\_alldat > tt1"); 
system("mv tt1 $dataset\_alldat");
$output="$j,$l2\n";
print "Pixels: $l2\n";
$j++;
system("cp t1_gs.x t1_bk");
## Removing pixels in t1.x from dataset ###
system("cat t1_gs.x $dataset | sort -t ' ' -k 5 | uniq -u -f 5 > t2");
system("cp t2 $dataset");
### Remove any blank lines in a file ###
system("sed '/^[ ]*\$/d' $dataset > tt");
system("mv tt $dataset");
system("sed '/^[ ]*\$/d' t1_gs.x > tt");
system("mv tt t1_gs.x");
open(FH,">t1_gs.x");
open(FI,"<$dataset");
@all=<FI>;
print "$all[0]\n";
print FH "$all[0]\n";
close(FI);
close(FH);
$out = `wc -l $dataset`;
@o = split(/[\ ]+/,$out);
$l2=$o[1];
print "Number of Lines in $dataset: $l2\n";
open(JP,">>$dataset\_output");
print JP "$output";
}

}


