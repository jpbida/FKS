### This script merges all datafiles with compartment data and condenses them into one file ####
dataset<-"test"
#seqs<-seq(0,100,by=5)
seqs<-c(0,5,10)
for(n in seqs){
		file=paste(dataset,"_d",n,"_alldat",sep="")
		if(n==0){
		d1<-read.table(file=file)
		names(d1)<-c("c0","x","y","z")
		}else{
		d2<-read.table(file=file)
		names(d2)<-c(paste("c",n,sep=""),"x","y","z")
		d1<-merge(d1,d2,by=c("x","y","z"),all=T)
		}
}
### After merging all datasets determine which compartments overlap ###
print("merged")
plist<-NULL
for(n in 1:(length(seqs)-1)){
	print(n)
	p<-table(d1[,names(d1)==paste("c",seqs[n],sep="")],d1[,names(d1)==paste("c",seqs[(n+1)],sep="")])
### Condense the columns of the table ###
		for(i in 1:dim(p)[1]){
		t<-as.numeric(names(p[i,p[i,]>0]))
	plist[[i]]<-t
		}	
#### Using the list that was generated changes values in d1 ###
mod<-c(1:max(as.numeric(dimnames(p)[[2]])))
for(i in 1:length(plist)){
mod[plist[[i]]]<-i
		}
d1[,names(d1)==paste("c",seqs[(n+1)],sep="")]<-mod[d1[,names(d1)==paste("c",seqs[(n+1)],sep="")]]


}

plist<-NULL
for(n in length(seqs):2){
	print(n)
	p<-table(d1[,names(d1)==paste("c",seqs[n],sep="")],d1[,names(d1)==paste("c",seqs[(n-1)],sep="")])
### Condense the columns of the table ###
		for(i in 1:dim(p)[1]){
		t<-as.numeric(names(p[i,p[i,]>0]))
	plist[[i]]<-t
		}	
#### Using the list that was generated changes values in d1 ###
mod<-c(1:max(as.numeric(dimnames(p)[[2]])))
for(i in 1:length(plist)){
mod[plist[[i]]]<-i
		}
d1[,names(d1)==paste("c",seqs[(n-1)],sep="")]<-mod[d1[,names(d1)==paste("c",seqs[(n-1)],sep="")]]


}

for(i in 1:dim(d1)[1]){
d1$c0[i]<-min(d1[i,4:(3+length(seqs))],na.rm=TRUE)
}

#d1<-d1[,1:4]
write.table(d1,file=paste("comp_",dataset,sep=""),row.names=F)

