translate<-function(data,x,y,z){
data<-as.data.frame(data)
write.table(data,file="all.dat",append=TRUE,row.names=FALSE,col.names=FALSE)
#data <- dataset containing x,y,z coordinates #
#x,y,z defines the translation #
	data$x<-data$x+x
		data$y<-data$y+y
		data$z<-data$z+z
		data<-as.data.frame(data)
		data
}


### Takes in a dataset containing sphere centers and their radius and calculates the
## fractal dimension of the accessible volume ####
 sphere2pix<-function(grid_size,center,radius){
## Create set of pixels centered at 0,0 ##
## Geneterate square with center pixel = 0,0 and sides = 2*r ##
	 pixels<-NULL
		 num_pix<-(2*radius/grid_size)
		 j<-1
		 for(x in 1:num_pix){
			 for(y in 1:num_pix){
				 for(z in 1:num_pix){
					         pixels$x[j]<-(x)
						 pixels$y[j]<-(y)
						 pixels$z[j]<-(z)
						 pixels$filled[j]<-0
						 j<-j+1
				 }
			 }
		 }
	 pixels<-as.data.frame(pixels)
		 print(max(pixels$x))
		 shift<-median(c(1:max(pixels$x)))
		 print(shift)
		 pixels<-translate(pixels,(-1*shift),(-1*shift),(-1*shift))
		 r<-dim(pixels)[1]
## Keep set of all pixels with centers that are < r from 0,0 ## 
		 for(i in c(1:r)){
#print(i)
			 dist<-sqrt(pixels$x[i]^2+pixels$y[i]^2+pixels$z[i]^2)
				 if(dist<(radius/grid_size)){
					 pixels$filled[i]<-1
				 }
		 }

#center<-(round((center/grid_size))*grid_size - grid_size/2)
## Translate to closest pixel to center of the sphere ###
		 pixels<-translate(pixels,center[1],center[2],center[3])
		 pixels

 }

#### Takes dataset of spheres and pixelizes them ####
pixelize<-function(spheredat){
## pixels 0.1 ##
	d1<-NULL
#load("~/projects/p1000/FractalDim/sphere1.dat")
#d1<-d1+0.05
#d1<-d1*10
## pixels 0.5 ##
#load("~/projects/p1000/FractalDim/sphere1.dat")
### 0.391 pixel size ###
load("~/projects/p1000/FractalDim/sphere0_391.dat")
d1<-d1[,1:3]	
	
	data<-NULL
print(dim(d1))
for(j in 1:dim(spheredat)[1]){
s1<-translate(d1,spheredat$x[j],spheredat$y[j],spheredat$z[j])
if(j==1){
data<-s1
data<-as.data.frame(data)
}else{
data<-rbind(data,s1)
}	
if(j%%10==0 || j==dim(spheredat)){
	write.table(data,file="out.dat",append=TRUE,row.names=FALSE,col.names=FALSE)
	data<-data[1,]
	print(j)
}
}
	
}

create3d<-function(space_size,fileout){
### Create a dataset of all points in 3D ###
i<-1
j<-1
data<-NULL
for(x in 0:space_size){
print(x)
	for(y in 0:space_size){
		for(z in 0:space_size){
data$x[i]<-x
data$y[i]<-y
data$z[i]<-z
i<-i+1
j<-j+1
if(i%%100==0){
data<-as.data.frame(data)
write.table(data,file=fileout,append=TRUE,row.names=FALSE,col.names=FALSE)
data<-NULL
i<-1
}
		}
	}
}
data<-as.data.frame(data)
write.table(data,file=fileout,append=TRUE,row.names=FALSE,col.names=FALSE)
}
