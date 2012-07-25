#################
#datasets<-c("allr4_75.px","allr4_50.px","allr4_25.px","allr3_75.px","allr3_50.px","allr3_25.px","allr2_75.px","allr2_50.px","allr2_25.px","allr1_75.px","allr1_50.px","allr1_25.px")
datasets<-c("test1")
for(dataset in datasets){

system(paste("sort ",dataset," -o ",dataset,sep=""))
dat<-read.table(file=dataset)
names(dat)<-c("x","y","z")
### Calculate the pixels that are in the 6-neighborhood of each pixel ##

### Creates a dataset ALLPIXS containing the following format ###
# x y z p1 p2 p3 p4 p5 p6 
# Where x y z are the pixels coordinates and p1-p6 are the neighboring pixels that are in the accessible volume and connected to the pixel at the given coordinates 
d1<-move(dat,1,0,0)
d2<-move(dat,0,1,0)
d3<-move(dat,0,0,1)
d4<-move(dat,-1,0,0)
d5<-move(dat,0,-1,0)
d6<-move(dat,0,0,-1)


write.table(d1,file="c100.px",row.names=F,col.names=F)
write.table(d2,file="c010.px",row.names=F,col.names=F)
write.table(d3,file="c001.px",row.names=F,col.names=F)
write.table(d4,file="cN00.px",row.names=F,col.names=F)
write.table(d5,file="c0N0.px",row.names=F,col.names=F)
write.table(d6,file="c00N.px",row.names=F,col.names=F)

sets<-c("100","010","001","N00","0N0","00N")
for(s in sets){
	print(s)
cmd<-paste("cat ",dataset," c",s,".px > t1.px",sep="")
system(cmd)
system("sort t1.px -o t2.px")
system(paste("uniq -d t2.px > p",s,".x",sep=""))
system("rm t1.px t2.px")
}

for(s in sets){
c1<-paste("cat ",dataset," p",s,".x | sort | uniq -c  | awk '/ / {print $1}' > o",s,".x",sep="")
system(c1)
}

rm(list=c("o1"))
for(s in sets){
o<-read.table(file=paste("o",s,".x",sep=""))
if(exists("o1")){
o1<-cbind(o1,o)
}else{
	o1<-o
}
}
### o1 contains p1-p6 for the dataset file ###
out<-cbind(o1,dat)
names(out)<-c("p1","p2","p3","p4","p5","p6","x","y","z")
write.table(out,file=paste("allpixs_",dataset,sep=""),row.names=F)
}
