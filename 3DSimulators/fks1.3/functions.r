##### Identifies probability of fragment being found in certain positon ###
#x<-runif(400)*20
#y<-runif(400)*20
#z<-runif(400)*20
#dat<-NULL
#dat$x=x
#dat$y=y
#dat$z=z
#dat<-as.data.frame(dat)

#### Outputs X,Y,Z centers of boxes and number of points in each ##
#boxCounts(dat,5)

############################################################
#Functions for box counting  #
############################################################
inPixel<-function(x,y,z,r,dat){
## Determines how many points in dat are in the pixel with lower left corner at x,y,z and edge length r ###
keep<-dat$x < (x+r/2) & dat$x > (x-r/2) & dat$y > (y-r/2) & dat$y < (y+r/2) & dat$z < (z+r/2) & dat$z > (z-r/2) 
	t<-dat$x[keep]
	N = length(t)
	ids=dat$id[keep]
	out<-list(N=N,ids=ids)
out
}

boxKeep<-function(out,pct){
#### Sorts boxes by number of elements ###
	out<-as.data.frame(out)
ord<-order(out$n,decreasing=TRUE)
nums<-out$n[ord]
tots<-NULL
for(i in 1:length(nums)){
tots[i]<-sum(nums[1:i])
}

tot<-sum(nums)
m<-tot*pct
ind<-c(1:length(tots))[tots < m]
int<-c(ind,max(ind)+1)
out<-out[ord,]
out<-out[ind,]
out
}

boxNums<-function(out){
pct<-NULL
	for(j in 1:100){
p<-j/100
	o2<-boxKeep(out,p)
	pct[j]=length(o2$x)
	}
pct
}



boxCounts<-function(dat,r){
xmax=max(dat$x)
ymax=max(dat$y)
zmax=max(dat$z)
xmin=min(dat$x)
ymin=min(dat$y)
zmin=min(dat$z)
amax<-max(c(xmax,ymax,zmax))
amin<-min(c(xmin,ymin,zmin))
s<-seq(amin,amax,by=r)
out<-NULL
i=1
j=1
ids<-NULL
for(x1 in s){
for(y1 in s){
for(z1 in s){
out$x[i]=x1
out$y[i]=y1
out$z[i]=z1
L = inPixel(x1,y1,z1,r,dat)
N=L[[1]]
lid=L[[2]]
out$n[i]=N
out$id[i]=i
if(N==1){
tmpF<-dat[dat$id==lid[1],]
	out$x[i]=tmpF$x[1]
	out$y[i]=tmpF$y[1]
	out$z[i]=tmpF$z[1]
}

for(id in lid){
ids$bin_id[j]=i
ids$frag_id[j]=id
j<-j+1
}
i<-i+1
}
}
}
li<-NULL
li[[1]]=out
li[[2]]=ids
li
}


genLibs<-function(all,prefix=""){
#### All is the fragment library ids merged with vectors #####
### Single Stranded library ###
### Pick 500 moves randomly from each list ###
types=table(all$seq)
types=names(types)

for(type in types){
tmp<-all[all$seq==type,]
m<-dim(tmp)[1]
#### Random sample of size 500 ###
tmp<-tmp[sample(m,500),]
o<-boxCounts(tmp,2)
pixs<-as.data.frame(o[[1]])
pixs<-pixs[pixs$n>0,]
frags<-as.data.frame(o[[2]])
### Need to create bin_id -> frag_id map ####
write.table(pixs,file=paste("libs/",prefix,type,".vect",sep=""),row.names=FALSE,col.names=TRUE)
write.table(frags,file=paste("libs/",prefix,type,".map",sep=""),row.names=FALSE,col.names=TRUE)
}
}





