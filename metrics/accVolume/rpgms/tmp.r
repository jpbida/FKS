#dat<-read.table(file="test100_3.dat")
dist<-function(dat,x,y,z){
        dist<-NULL
for(i in 1:dim(dat)[1]){
dist[i]<-sqrt((dat$x[i]-x)^2 +(dat$y[i]-y)^2 +(dat$z[i]-z)^2)
}
mdist<-min(dist)
mdist
}

dat1<-dat[dat$x<10,]
dat1<-dat1[dat1$y<10,]
dat1<-dat1[dat1$z<10,]
j<-1
out<-NULL
x1<-seq(3.8,4.2,by=0.05)
y1<-seq(4.1,4.5,by=0.05)
z1<-seq(3.4,3.8,by=0.05)
for(x in x1){
print(x)
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
