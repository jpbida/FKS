### For each of the datasets ###
datasets<-c(
"allr4_75.px",
"allr4_50.px",
"allr4_25.px",
"allr3_75.px",
"allr3_50.px",
"allr3_25.px",
"allr2_75.px",
"allr2_50.px",
"allr2_25.px",
"allr1_75.px",
"allr1_50.px",
"allr1_25.px"
)

#### Break the space into cross sections squares ####
for(dataset in datasets[1])
{
print(dataset)
fin<-paste("allpixs_",dataset,sep="")
dat<-read.table(file=fin,header=F)
names(dat)<-c("p1","p2","p3","p4","p5","p6","x","y","z")
out<-NULL
for(x in seq(0,100,by=5)){
print(x)
d1<-dat[dat$x<x+2 & dat$x>=x,]
write.table(d1,file=paste(dataset,"_d",x,sep=""),row.names=F,col.names=F)
#### Calculate all compartments in the space ###
pix<-read.table(file=paste(dataset,"_d",x,sep=""),nrows=1)
write.table(pix[1,],file="t1.x",row.names=F,col.names=F)
while(dim(pix)[1]>0){
system(paste("./gset.pl ",dataset,"_d",x,sep="")) 
}
}
}
