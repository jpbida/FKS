### Centers for radius 3 crowding ###
odat<-NULL
x1<-seq(6,100,by=6)
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

x2<-seq(3,100,by=6)
y2<-seq(11.66,100,by=10.393)
z2<-seq(5.45,100,by=9.8)

for(x in x2){
for(y in y2){
for(z in z2){
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
