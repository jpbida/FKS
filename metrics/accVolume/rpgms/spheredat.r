source("~/projects/p1000/metrics/accVolume/rpgms/pixels.r")

rads<-seq(.976,20,by=.976)
for(r in rads){
	print(r)
d1<-sphere2Dpix(0.976,c(0,0,0),r)
d1<-d1[d1$filled==1,]
d1<-d1[,1:3]
assign(paste("sphere",r,sep=""),d1)
}
alldat<-paste("sphere",rads,sep="")
save(list=alldat,file="~/projects/p1000/metrics/accVolume/rpgms/sphere.dat")
