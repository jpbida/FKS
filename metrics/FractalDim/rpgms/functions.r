
fdim<-function(file_in,dataset,res,size_space){
frac_data<-NULL
i<-2
### Calculate fractal dimension ####
steps<-c(2*res,4*res,8*res,16*res,32*res,64*res,128*res)
#steps<-seq(0.2,1,by=0.1)
system(paste("cp ",file_in," out.dat",sep=""))
for(boxsize in steps){
## Get number of lines in out.dat ##
lines<-system('wc -l out.dat',intern=T)
l<-strsplit(lines," ")
lines<-as.numeric(l[[1]][length(l[[1]])-1])
## Readlines of datafile 1000 at a time and convert ##
### Convert to grid size ###
start<-0
print(paste("Converting Grid Size: ",boxsize,sep=""))
if(lines > 50000){
	sends<-c(seq(10000,lines,by=10000),lines)
}else{
	sends<-lines
}
for(end in sends){
print(end)
dat<-read.table(file="out.dat",skip=start,nrows=(end-start))
start<-end
if(boxsize==2*res){
	print("chopping")
for(j in 1:dim(dat)[2]){
dat[,j]<-pmin(dat[,j],(floor(size_space/res)-1))
}
}
#newdat<-floor(dat/(boxsize/res))
newdat<-floor(dat/2)
write.table(newdat,file="out1.dat",append=T,col.names=F,row.names=F)
}
if(boxsize==2*res){
lines<-system('wc -l out.dat',intern=T)
l<-strsplit(lines," ")
lines<-as.numeric(l[[1]][(length(l[[1]])-1)])
frac_data$n[1] = ((size_space/res)^3-lines)
frac_data$r[1] = res
frac_data$vol[1]=(size_space/res)^3
frac_data$lines[1]=lines
}
### Eliminate multiples ###
## Here we will use sort and uniq system commands to modify the datasets ##	
system('sort out1.dat -o out2.dat')
system('uniq out2.dat  out3.dat')
tot<-system('wc -l out3.dat',intern=T)
l<-strsplit(tot," ")
## total number of pixels covering the spheres ##
tot<-as.numeric(l[[1]][(length(l[[1]])-1)])
print(tot)
## Total number of pixels covering the accessible volume ##
frac_data$n[i]<-(size_space/boxsize)^3 - tot
frac_data$r[i]<-boxsize
frac_data$vol[i]=(size_space/boxsize)^3
frac_data$lines[i]=tot
i<-i+1
system(paste("cp out3.dat out_",boxsize,".dat",sep=""))
#system('rm out1.dat out2.dat')
system('rm out.dat out1.dat out2.dat')
system('mv out3.dat out.dat')
}
frac_data<-as.data.frame(frac_data)
system('rm out.dat')
#fit<-glm(log(frac_data$n)~log((1/frac_data$r)))
fit2<-glm(log(frac_data$lines)~log((1/frac_data$r)))
#dimension<-fit$coeff[2]
dimension2<-fit2$coeff[2]
print(paste("Fractal Dimension = ",dimension2,sep=""))
save(frac_data,file=paste("F1output_",dataset,sep=""))
frac_data<-NULL
}
