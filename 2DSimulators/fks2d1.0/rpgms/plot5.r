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
dat1<-read.table('debug.csv',sep=',')
tmax<-100
xmax<-30
ymax<-30
for(i in 0:tmax){
	file<-paste("jpegs/C1_out",floor((i%%10000)/1000),floor((i%%1000)/100),floor((i%%100)/10),(i%%10),".jpeg",sep="")
		print(file)
		keep1 <- dat1[,1] == i
		time1 <- dat1[keep1,1:11]
		cols1<-(time1[,11]+1)
		cols1[time1[,7]==1]<-4
		jpeg(file=file,width=500,height=500)

plot(c(0,0),c(30,0),ylim=c(0,ymax),xlim=c(0,xmax),ylab="",xlab="",axes=FALSE,type='n')
box()
points(time1[,3],time1[,4],pch=16,cex=(time1[,9]*3.5),col=cols1)
dev.off()
}
