dat<-read.table(file="test100_3.dat")
names(dat)<-c("x","y","z","radius","type")

### Calculate all distances from a given point ##
#dat<-dat[dat$x<12,]
#dat<-dat[dat$y<12,]
#dat<-dat[dat$z<12,]
dist<-function(dat,x,y,z){
	dist<-NULL
for(i in 1:dim(dat)[1]){
dist[i]<-sqrt((dat$x[i]-x)^2 +(dat$y[i]-y)^2 +(dat$z[i]-z)^2)
}
mdist<-min(dist)
mdist
}
j<-1
pt<-NULL
out<-NULL
if(count==1){
x1<-6
	y1<-seq(6.46,100,by=10.393)
	z1<-seq(5.45,100,by=9.8)
	
for(x in x1){
for(y in y1){
for(z in z1){
print(paste(x,y,z,sep=" "))
tmp<-dist(dat,x,y,z)
out$dist[j]<-tmp
out$x[j]<-x
out$y[j]<-y
out$z[j]<-z
	j<-j+1	
}
}
}
}

out<-as.data.frame(out)
# plot(out$x[out$y==10 & out$z==10],out$dist[out$y==10 & out$z==10])
dx6<-dat[dat$x==12,]
dx3<-dat[dat$x==9,]
dx9<-dat[dat$x==15,]
 plot(dx6$y,dx6$z,cex=(5*3/4),ylim=c(0,100),xlim=c(0,100))
 points(dx3$y,dx3$z,cex=.5,col=3)
 points(dx9$y,dx9$z,cex=.5)
### Centers for radius 3 crowding ###
odat<-NULL
x1<-seq(12,100,by=6)
y1<-seq(6.46,100,by=10.393)
z1<-seq(5.45,100,by=9.8)

i<-1
for(x in x1){
for(y in y1){
for(z in z1){
odat$x[i]<-x
odat$y[i]<-y
odat$z[i]<-z
i<-i+1
}
}
}
odat<-as.data.frame(odat)
write.table(odat,file="alt3.dat",row.names=F,col.names=F)

#### Centers for radius 4 crowding ####
i<-1
odat<-NULL
for(x in seq(8,100,by=8)){
for(y in seq(8.5,100,by=13.9)){
for(z in seq(7.5,100,by=6.5)){
odat$x[i]<-x
odat$y[i]<-y
odat$z[i]<-z
i<-i+1
}
}

}

for(x in seq(4,100,by=8)){
	for(y in seq(15.5,100,by=13.9)){
		for(z in seq(7.5,100,by=6.5)){
odat$x[i]<-x
odat$y[i]<-y
odat$z[i]<-z
i<-i+1
		
		}
	}
}


odat<-as.data.frame(odat)

write.table(odat,file="alt4.dat",row.names=F,col.names=F)
