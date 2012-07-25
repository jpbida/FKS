### Determines the number of compartments in each space ###
### Determines the number of compartments in each space ###
### Use 4-connectivity for pixels ###

### Functions ###
removeFrist<-function(fin,fout){
cmd<-paste("cat ",fin," | awk '/ / {print $1}' > ",fout,sep="")
system(cmd)
}


##### GenPixs #####
genPixs<-function(row){
pout<-NULL
pout<-row
for(i in 1:6){
or<-rbind(c(-1,0,0),c(0,-1,0),c(0,0,-1),c(1,0,0),c(0,1,0),c(0,0,1))
if(row[i]==2){
if(is.null(pout)){
	pout<-move(row,or[i,1],or[i,2],or[i,3])
}else{
p<-move(row,or[i,1],or[i,2],or[i,3])
pout<-rbind(pout,p)
}
}
}
pout	
}

genSet2<-function(fin,fout){
l<-system(paste("wc -l ",fin,sep=""),intern=T)
l<-strsplit(l," ")
l<-as.numeric(l[[1]][(length(l[[1]])-1)])
print(l)
### Given a pixel generate the set of all pixels it is connected to ###
#pixs == Index of the pixels to expand 
#dat == ALLPIX dataset
pixs<-read.table(file=fin)
names(pixs)<-c("p1","p2","p3","p4","p5","p6","x","y","z")
## expand checklist to include neighboring pixels ###
for(i in 1:dim(pixs)[1]){
	out2<-genPixs(pixs[i,])
	write.table(out2,file="tmpA.px",append=T,row.names=F,col.names=F)
}
system(paste("cat tmpA.px ",fout," | sort -t ",'"'," ",'"'," -k 7 | uniq -d -f 7 > ",fin,sep=""))
system("rm tmpA.px")
l2<-system(paste("wc -l ",fin,sep=""),intern=T)
l2<-strsplit(l2," ")
l2<-as.numeric(l2[[1]][(length(l2[[1]])-1)])

if(l2 > l){
genSet2(fin,fout)
}else{
return(1)
}

}
###### Move Function #####
move<-function(dat,x,y,z){
	dat$x<-dat$x+x
	dat$y<-dat$y+y
	dat$z<-dat$z+z
n<-c(1:dim(dat)[2])[names(dat) %in% c("x","y","z")]
others<-setdiff(c(1:dim(dat)[2]),n)
		dat[,others]<-9
	dat
}

############################################
