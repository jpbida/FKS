s<-c(0:1023)
dat<-NULL
j<-1
for(x in s){
	for(y in s){
dat$x[j]<-x
dat$y[j]<-y
dat$z[j]<-0
j<-j+1
	}
}
dat<-as.data.frame(dat)
write.table(dat,file="~/projects/p1000/metrics/accVolume/data/all2d_1024",row.names=F,col.names=F)

s<-c(0:511)
dat<-NULL
j<-1
for(x in s){
	for(y in s){
dat$x[j]<-x
dat$y[j]<-y
dat$z[j]<-0
j<-j+1
	}
}
dat<-as.data.frame(dat)
write.table(dat,file="~/projects/p1000/metrics/accVolume/data/all2d_512",row.names=F,col.names=F)
