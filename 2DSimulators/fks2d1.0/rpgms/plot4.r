# t 
# mols[j]->id 
# mols[j]->x 
# mols[j]->y 
# mols[j]->z 
# mols[j]->isMain 
# mols[j]->isbound 
# mols[j]->bound 
# mols[j]->r 
# mols[j]->num_list 
# mols[j]->type;



circle <- function(x,y,r,cols,xmax,ymax){
xo<-NULL
ao<-NULL
yo<-NULL

#text(x,y,bn)

for(i in 0:360){
x1<- r
y1<- 0
a<-(i/360)*2*3.14
x2<- x1*cos(a)-y1*sin(a)+x
y2<- y1*cos(a)+x1*sin(a)+y
points(x2,y2,pch='.',col=(cols))
xo[i]<-x1
yo[i]<-y1
ao[i]<-a
}


#out<-cbind(ao,xo,yo)
#out
}

dat<-read.table('test_dbg.csv',sep=',')

r<-c(1,1,1,1,1)

#points(time[,3],time[,4],pch=16,cex=time[,9],col=(1+time[,11]))


for(i in 300:330){
	file<-paste("jpegs/debug/C60_out",floor((i%%10000)/1000),floor((i%%1000)/100),floor((i%%100)/10),(i%%10),".jpeg",sep="")
	print(file)
keep <- dat[,1] == i
time <- dat[keep,1:11]
ymax=30
xmax=30
jpeg(file=file,width=500,height=500)
plot(c(0,0),c(30,0),ylim=c(-5,ymax),xlim=c(-5,xmax),type='n')
for(j in 1:dim(time)[1]){
	if(time[j,3] < xmax && time[j,4] < ymax){
		if(time[j,7]==1){
			cols=4
		}else{
		cols=(1+time[j,11])
		}
	circle(time[j,3],time[j,4],time[j,9],cols,xmax,ymax)
	text(time[j,3],time[j,4],paste(time[j,10],time[j,2],time[j,7],time[j,6],sep="\n"))
#numlist,id,ismain,isbound
	}
}	
dev.off()
}	

