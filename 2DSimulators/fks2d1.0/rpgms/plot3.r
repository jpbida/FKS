# t 
# mols[j]->id 
# mols[j]->x 
# mols[j]->y 
# mols[j]->z 
# mols[j]->isMain 
# mols[j]->isbound 
# mols[j]->bound 
# mols[j]->r 
# mols[j]->num_list 
# mols[j]->type



# Reads in data outputted from FKS simulator #
# 
dat1<-read.table('test_sizedbg.csv',sep=',')
tmax<-200
xmax<-30
ymax<-30
rmax<-5
names(dat1)<-c("t","id","x","y","z","ismain","isbound","bid","r","numlist","type","v1","v2","v3")

m1<-dat1[seq(4,dim(dat1)[1],by=12),]
m2<-dat1[seq(5,dim(dat1)[1],by=12),]
m3<-dat1[seq(6,dim(dat1)[1],by=12),]
m4<-dat1[seq(7,dim(dat1)[1],by=12),]
m5<-dat1[seq(8,dim(dat1)[1],by=12),]
m6<-dat1[seq(9,dim(dat1)[1],by=12),]
m7<-dat1[seq(10,dim(dat1)[1],by=12),]
m8<-dat1[seq(11,dim(dat1)[1],by=12),]

for(i in 1:tmax){
	file<-paste("jpegs/C1_out",floor((i%%10000)/1000),floor((i%%1000)/100),floor((i%%100)/10),(i%%10),".jpeg",sep="")
		print(file)
		keep1 <- as.numeric(dat1[,1]) == i & as.numeric(dat1[,2]) > 3
		time1 <- dat1[keep1,1:11]
		cols1<-(time1[,11]+1)
		cols1[time1[,7]==1]<-4
		size<-(time1[,9]/(rmax+ymax))*100
		jpeg(file=file,width=500,height=500)
plot(c(0,0),c(30,0),ylim=c((0-rmax),(ymax+rmax)),xlim=c((0-rmax),(xmax+rmax)),ylab="",xlab="",axes=TRUE,type='n')
box()
points(time1[,3],time1[,4],pch=16,cex=size,col=cols1)
dev.off()
}


