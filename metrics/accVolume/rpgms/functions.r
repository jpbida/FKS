#### accVol takes in a pixelized(0.976) version of the crowding molecules and determines the accessible volume of a sphere of radius 1 ####
accVol<-function(file_in,d){
print(paste("Calculating Accessible Volume: ",dataset,sep=""))
#### Generate the list of all spheres on the lattice that are not occupied by a boundary ####
### dat4 and dat5 contain all pixels that are not in the crowded molecules space ###
print("Creating 8 out files")
dat4<-read.table(file="out.dat")
names(dat4)<-c("x","y","z")
### Approximate each sphere as a cube of 4 pixels ####
dat5<-floor(dat4/2)
write.table(dat5,file="out000.dat",row.names=F,col.names=F)
if(d==3){
dat4$x<-dat4$x+1
dat5<-floor(dat4/2)
print("100")
write.table(dat5,file="out100.dat",row.names=F,col.names=F)
dat4$y<-dat4$y+1
dat5<-floor(dat4/2)
write.table(dat5,file="out110.dat",row.names=F,col.names=F)
print("100")
dat4$z<-dat4$z+1
dat5<-floor(dat4/2)
write.table(dat5,file="out111.dat",row.names=F,col.names=F)
print("100")
dat4$y<-dat4$y-1
dat5<-floor(dat4/2)
write.table(dat5,file="out101.dat",row.names=F,col.names=F)
print("100")
dat4$x<-dat4$x-1
dat5<-floor(dat4/2)
write.table(dat5,file="out001.dat",row.names=F,col.names=F)
print("100")
dat4$y<-dat4$y+1
dat5<-floor(dat4/2)
write.table(dat5,file="out011.dat",row.names=F,col.names=F)
print("100")
dat4$z<-dat4$z-1
dat5<-floor(dat4/2)
write.table(dat5,file="out010.dat",row.names=F,col.names=F)
print("100")
}
if(d==2){
dat4$x<-dat4$x+1
dat5<-floor(dat4/2)
print("100")
write.table(dat5,file="out100.dat",row.names=F,col.names=F)
dat4$y<-dat4$y+1
dat5<-floor(dat4/2)
write.table(dat5,file="out110.dat",row.names=F,col.names=F)
print("110")
dat4$x<-dat4$x-1
dat5<-floor(dat4/2)
write.table(dat5,file="out010.dat",row.names=F,col.names=F)
print("010")
}
if(d==3){
system("sort out000.dat -o t000.dat")
system("sort out010.dat -o t010.dat")
system("sort out011.dat -o t011.dat")
system("sort out001.dat -o t001.dat")
system("sort out100.dat -o t100.dat")
system("sort out110.dat -o t110.dat")
system("sort out111.dat -o t111.dat")
system("sort out101.dat -o t101.dat")
system("uniq -c t000.dat > out000.dat")
system("uniq -c t010.dat > out010.dat")
system("uniq -c t011.dat > out011.dat")
system("uniq -c t001.dat > out001.dat")
system("uniq -c t100.dat > out100.dat")
system("uniq -c t110.dat > out110.dat")
system("uniq -c t111.dat > out111.dat")
system("uniq -c t101.dat > out101.dat")
}
if(d==2){
system("sort out000.dat -o t000.dat")
system("sort out010.dat -o t010.dat")
system("sort out100.dat -o t100.dat")
system("sort out110.dat -o t110.dat")
system("uniq -c t000.dat > out000.dat")
system("uniq -c t010.dat > out010.dat")
system("uniq -c t100.dat > out100.dat")
system("uniq -c t110.dat > out110.dat")
}
### Map back to pixels of half size ###
if(d==3){
d1<-read.table(file="out000.dat")
d2<-read.table(file="out010.dat")
d3<-read.table(file="out011.dat")
d4<-read.table(file="out001.dat")
d5<-read.table(file="out100.dat")
d6<-read.table(file="out110.dat")
d7<-read.table(file="out111.dat")
d8<-read.table(file="out101.dat")
names(d1)<-c("c","x","y","z")
names(d2)<-c("c","x","y","z")
names(d3)<-c("c","x","y","z")
names(d4)<-c("c","x","y","z")
names(d5)<-c("c","x","y","z")
names(d6)<-c("c","x","y","z")
names(d7)<-c("c","x","y","z")
names(d8)<-c("c","x","y","z")
system("rm out000.dat out010.dat out011.dat out100.dat out111.dat out101.dat")
d1<-d1[d1$c==8,]
d2<-d2[d2$c==8,]
d3<-d3[d3$c==8,]
d4<-d4[d4$c==8,]
d5<-d5[d5$c==8,]
d6<-d6[d6$c==8,]
d7<-d7[d7$c==8,]
d8<-d8[d8$c==8,]
d1<-d1*2
d2<-d2*2
d3<-d3*2
d4<-d4*2
d5<-d5*2
d6<-d6*2
d7<-d7*2
d8<-d8*2

d2$y<-d2$y-1
d3$y<-d3$y-1
d3$z<-d3$z-1
d4$z<-d4$z-1
d5$x<-d5$x-1
d6$x<-d6$x-1
d6$y<-d6$y-1
d7$y<-d7$y-1
d7$x<-d7$x-1
d7$z<-d7$z-1
d8$x<-d8$x-1
d8$z<-d8$z-1

write.table(d1[2:4],file=paste("all",dataset,".px",sep=""),append=T,row.names=F,col.names=F)
write.table(d2[2:4],file=paste("all",dataset,".px",sep=""),append=T,row.names=F,col.names=F)
write.table(d3[2:4],file=paste("all",dataset,".px",sep=""),append=T,row.names=F,col.names=F)
write.table(d4[2:4],file=paste("all",dataset,".px",sep=""),append=T,row.names=F,col.names=F)
write.table(d5[2:4],file=paste("all",dataset,".px",sep=""),append=T,row.names=F,col.names=F)
write.table(d6[2:4],file=paste("all",dataset,".px",sep=""),append=T,row.names=F,col.names=F)
write.table(d7[2:4],file=paste("all",dataset,".px",sep=""),append=T,row.names=F,col.names=F)
write.table(d8[2:4],file=paste("all",dataset,".px",sep=""),append=T,row.names=F,col.names=F)
system("rm out.dat")
}
if(d==2){
d1<-read.table(file="out000.dat")
d2<-read.table(file="out010.dat")
d5<-read.table(file="out100.dat")
d6<-read.table(file="out110.dat")
names(d1)<-c("c","x","y","z")
names(d2)<-c("c","x","y","z")
names(d5)<-c("c","x","y","z")
names(d6)<-c("c","x","y","z")
system("rm out000.dat out010.dat out100.dat out110.dat")
d1<-d1[d1$c==4,]
d2<-d2[d2$c==4,]
d5<-d5[d5$c==4,]
d6<-d6[d6$c==4,]
d1<-d1*2
d2<-d2*2
d5<-d5*2
d6<-d6*2

d2$y<-d2$y-1
d5$x<-d5$x-1
d6$x<-d6$x-1
d6$y<-d6$y-1

write.table(d1[2:4],file=paste("all",dataset,".px",sep=""),append=T,row.names=F,col.names=F)
write.table(d2[2:4],file=paste("all",dataset,".px",sep=""),append=T,row.names=F,col.names=F)
write.table(d5[2:4],file=paste("all",dataset,".px",sep=""),append=T,row.names=F,col.names=F)
write.table(d6[2:4],file=paste("all",dataset,".px",sep=""),append=T,row.names=F,col.names=F)
system("rm out.dat")
}
}# end radius

