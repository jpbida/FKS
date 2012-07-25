### SAMPLE code to make videos of each simulation ####
#### R CMD BATCH plot

dat1<-read.table('debug1.csv',sep=',')
dat2<-read.table('debug2.csv',sep=',')
dat3<-read.table('debug3.csv',sep=',')
dat4<-read.table('debug4.csv',sep=',')
tmax<-100
xmax<-100
ymax<-100
for(i in 0:tmax){
	file<-paste("jpegs/C1_out",floor((i%%10000)/1000),floor((i%%1000)/100),floor((i%%100)/10),(i%%10),".jpeg",sep="")
		print(file)
		keep1 <- dat1[,1] == i
		time1 <- dat1[keep1,1:11]
		cols1<-(time1[,11]+1)
		cols1[time1[,7]==1]<-4
		
		keep2 <- dat2[,1] == i
		time2 <- dat2[keep2,1:11]
		cols2<-(time2[,11]+1)
		cols2[time2[,7]==1]<-4

		keep3 <- dat3[,1] == i
		time3 <- dat3[keep3,1:11]
		cols3<-(time3[,11]+1)
		cols3[time3[,7]==1]<-4

		keep4 <- dat4[,1] == i
		time4 <- dat4[keep4,1:11]
		cols4<-(time4[,11]+1)
		cols4[time4[,7]==1]<-4

		jpeg(file=file,width=500,height=500)

		par(mfrow=c(2,2),mai=rep(0.02,4))
plot(c(0,0),c(30,0),ylim=c(0,ymax),xlim=c(0,xmax),ylab="",xlab="",axes=FALSE,type='n')
box()
points(time1[,3],time1[,4],pch=16,cex=(time1[,9]),col=cols1)
plot(c(0,0),c(30,0),ylim=c(0,ymax),xlim=c(0,xmax),ylab="",xlab="",axes=FALSE,type='n')
box()
points(time2[,3],time2[,4],pch=16,cex=(time2[,9]),col=cols2)
plot(c(0,0),c(30,0),ylim=c(0,ymax),xlim=c(0,xmax),ylab="",xlab="",axes=FALSE,type='n')
box()
points(time3[,3],time3[,4],pch=16,cex=(time3[,9]),col=cols3)
plot(c(0,0),c(30,0),ylim=c(0,ymax),xlim=c(0,xmax),ylab="",xlab="",axes=FALSE,type='n')
box()
points(time4[,3],time4[,4],pch=16,cex=(time4[,9]),col=cols4)
text(time4[,3],time4[,4],time[,10])
dev.off()
}
