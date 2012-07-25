### Creates a 2-d dataset for testing ###
dat<-NULL
i<-1
for(x in 0:127){
	for(y in 0:127){
	dat$x[i]<-x
dat$y[i]<-y
dat$z[i]<-50
i<-i+1
	}
}
dat<-as.data.frame(dat)
write.table(dat,file="out.dat",row.names=F,col.names=F)


### Creates a 3D dataset for testing ###

for(x in 20:40){
	for(y in 20:40){
		for(z in 20:40){
data$x[i]<-x
data$y[i]<-y
data$z[i]<-z
	
		}
	}
}
