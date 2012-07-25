#### Creates average of 3d simulations #####


source("functions.r")
runs<-c("c2","c3","c4")
conc<-c("50","75")
path<-"/Users/bida/projects/p1000/paper/data0706/3D/"
path2<-"/Users/bida/projects/p1000/paper/data0706/3D/c1/"
path3<-"/Users/bida/projects/p1000/paper/data0706/3D/c0/c1_2_00_"

dat<-dat_var(path3,1,99,1)
write.table(dat,file="av_dat_c0",row.names=F)
test<-2
if(test==1){
run<-"c1"
for(con in conc){
		file=paste(path2,"dat",con,"/c1_2_",con,"_",sep="")
print(file)
	dat<-dat_var(file,0,98,1)
write.table(dat,file=paste("av_dat_",run,"_",con,sep=""),row.names=F)
}
}
if(test==1){
### Averaging all data ####
for(run in runs){
	for(con in conc){
		file=paste(path,run,"/dat",con,"/",run,"_",con,"_",sep="")
print(file)
	dat<-dat_var(file,0,19,1)
write.table(dat,file=paste("av_dat_",run,"_",con,sep=""),row.names=F)
	}
}
}
