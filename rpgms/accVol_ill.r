d1<-read.table(file="/Users/bida/projects/p1000/metrics/accVolume/rpgms/vol_border3000")
d2<-read.table(file="/Users/bida/projects/p1000/metrics/accVolume/data/2D/allborder3000.px")
d0<-d1[d1[,1]>700 & d1[,1]<900 & d1[,2]>700 & d1[,2]<900,]
d3<-d2[d2[,1]>700 & d2[,1]<900 & d2[,2]>700 & d2[,2]<900,]

postscript(file="accvol_ill.ps",paper="letter",width=400,height=400)
plot(d0[,1],d0[,2],axes=F,col=1,pch=16,xlab="",ylab="")
points(d3[,1],d3[,2],col=3,pch=16)
box()
dev.off()

