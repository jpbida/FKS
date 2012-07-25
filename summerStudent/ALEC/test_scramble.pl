#!/usr/bin/perl

for($radius=1;$radius<5;$radius++){
open(FH,"<C$radius.dat");
@list = <FH>;
close(FH);
for($prct=0.25;$prct<1;$prct=$prct+0.25){
@list2=@list;
$outBND25="";
for($i=0;$i<($#list*$prct);$i++){
$rnd=int(rand($#list2));
$cord=$list2[$rnd];
chomp($cord);
splice(@list2,$rnd,1);
$outBND25.="$cord\t$radius\t2\n";
}

#### Generate 1000 A and 1000 B intial starting points from remaining ###
if($radius>2){
	open(FH2,"<alt$radius.dat");
@ltmp=<FH2>;
	@list3=(@list2,@ltmp);
}else{

	@list3=(@list2);
}

for($i=0; $i<10; $i++){
if($radius>2){
	open(FH2,"<alt$radius.dat");
@ltmp=<FH2>;
	@list3=(@list2,@ltmp);
}else{

	@list3=(@list2);
}
$outA="";
$outB="";
for($t=0; $t<2000;$t++){
$rnd=int(rand($#list3));
$cord=$list3[$rnd];
chomp($cord);
splice(@list3,$rnd,1);
if($t<1000){
$outA.="$cord\t1\t0\n";
}else{
	$outB.="$cord\t1\t1\n";
}

}
$lab=$prct*100;
open(FH3,">run_$lab\_$radius\_$i.dat");
print FH3 "$outA$outB$outBND25";
close(FH3);
}## End repeat
}## End percentage
}## End radius
