### For each of the datasets ###
datasets<-c(
"allpixs_allborder1500.px",
"allpixs_allborder3000.px",
"allpixs_allborder4500.px",
"allpixs_allborder16000.px",
"allpixs_allborder32000.px",
"allpixs_allborder64000.px"
)
datasets<-datasets[1]
#### Break the space into cross sections squares ####
for(dataset in datasets)
{
print(dataset)
fin<-dataset
dat<-read.table(file=fin,header=F)
names(dat)<-c("p1","p2","p3","p4","x","y","z")
out<-NULL
#### Calculate all compartments in the space ###
pix<-read.table(file=dataset,nrows=1)
write.table(pix[1,],file="t1.x",row.names=F,col.names=F)
system(paste("./gset2d.pl ",dataset,sep="")) 
}
