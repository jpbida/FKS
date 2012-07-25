dat<-read.table(file="test100_3.dat")
names(dat)<-c("x","y","z","radius","type")
### Distance Function ###
dist<-function(dat,x,y,z){
	dist<-NULL
for(i in 1:dim(dat)[1]){
dist[i]<-sqrt((dat$x[i]-x)^2 +(dat$y[i]-y)^2 +(dat$z[i]-z)^2)
}
mdist<-min(dist)
mdist
}
### Calculate all distances from a given point ##

for(xmin in seq(0,100,by=5)){
print(xmin)
for(ymin in seq(0,20,by=5)){
for(zmin in seq(0,20,by=5)){
dat1<-dat[dat$x>xmin & dat$x<(xmin+10),]
dat1<-dat1[dat1$y>ymin & dat1$y<(ymin+10),]
dat1<-dat1[dat1$z>zmin & dat1$z<(zmin+10),]
j<-1
pt<-NULL
out<-NULL
	x1<-seq(xmin,(xmin+10),by=1)
	y1<-seq(ymin,(ymin+10),by=1)
	z1<-seq(zmin,(zmin+10),by=1)
for(x in x1){
print(paste(x,y,z,sep=" "))
for(y in y1){
for(z in z1){
tmp<-dist(dat1,x,y,z)
out$dist[j]<-tmp
out$x[j]<-x
out$y[j]<-y
out$z[j]<-z
	j<-j+1	
}
}
}

out<-as.data.frame(out)
write.table(out,file="run100.dat",append=TRUE,row.names=F,col.names=F)
}
}
}
rb<-scatterplot3d(out$x,out$y,out$z,col=0)
keep<-out$dist>4
rb$points3d(out$x[keep],out$y[keep],out$z[keep],col=4)



### Low resolution view of sphere packing ###
dat1<-dat[dat$x<25,]
dat1<-dat1[dat1$y<25,]
dat1<-dat1[dat1$z<25,]
j<-1
out<-NULL
x1<-seq(0,20,by=1)
y1<-seq(0,20,by=1)
z1<-seq(0,20,by=1)
for(x in x1){
print(paste(x,y,z,sep=" "))
for(y in y1){
for(z in z1){
tmp<-dist(dat1,x,y,z)
out$dist[j]<-tmp
out$x[j]<-x
out$y[j]<-y
out$z[j]<-z
	j<-j+1	
}
}
}
out<-as.data.frame(out)

write.table(out,file="run100.dat",append=TRUE,row.names=F,col.names=F)



#### Calculating minimum cube in lattice ####

xv<-as.numeric(names(table(dat$x)))
yv<-as.numeric(names(table(dat$y)))
zv<-as.numeric(names(table(dat$z)))

xv<-xv[1:5]
yv<-yv[1:5]
zv<-zv[1:5]


dat1<-dat[dat$x<(xv[length(xv)]+1),]
dat1<-dat1[dat1$y<(yv[length(yv)]+1),]
dat1<-dat1[dat1$z<(zv[length(zv)]+1),]

j<-1
out<-NULL
x1<-seq(0,18,by=0.5)
y1<-seq(0,16,by=0.5)
z1<-seq(0,25,by=0.5)
for(x in x1){
print(as.character(x))
for(y in y1){
for(z in z1){
tmp<-dist(dat1,x,y,z)
out$dist[j]<-tmp
out$x[j]<-x
out$y[j]<-y
out$z[j]<-z
	j<-j+1	
}
}
}
out<-as.data.frame(out)









