#Calculates fractal dimension of x y z r file of positions for spheres

fractalDIM2D<-function(sphere){
xmax<-50
xmin<-0
ymax<-50
ymin<-0
box_n<-100
n<-NULL
s<-NULL
N<-NULL
ind<-1
z<-0
for(i in seq(1,20,by=1)){
n<-NULL
boxsize<-i
b<-1
for(x in 1:floor(50/i)){
	print(x)
for(y in 1:floor(50/i)){
#for(z in 1:floor(1000/i)){
t<-1
n[b]<-1
while(t < dim(sphere)[1]){
o<-ddist(sphere$x[t],sphere$y[t],sphere$z[t],sphere$r[t],x,y,z)
#print(o)
if(o < 0){
t <- dim(sphere)[1]
n[b]<-0
}
t<-t+1

}

b<-b+1
	
#}
}
}

N[ind]=sum(n)
s[ind]=boxsize
ind<-ind+1
}
out<-list(N=N,size=s)

}

fractalDIM<-function(sphere){
xmax<-10
xmin<-0
ymax<-10
ymin<-0
box_n<-10
n<-NULL
s<-NULL
N<-NULL
ind<-1
for(i in seq(1,6,by=1)){
	print(i)
n<-NULL
boxsize<-(xmax-xmin)/i * (ymax-ymin)/i
b<-1
for(x in 1:floor(10/i)){
	print(x)
for(y in 1:floor(10/i)){
for(z in 1:floor(10/i)){
t<-1
n[b]<-0
while(t < dim(sphere)[1]){
o<-ddist(sphere$x[t],sphere$y[t],sphere$z[t],sphere$r[t],x,y,z)
if(o < 0){
t <- dim(sphere)[1]
n[b]<-1
}
t<-t+1

}

b<-b+1
	
}
}
}

N[ind]=sum(n)
s[ind]=boxsize
ind<-ind+1
}
out<-list(N=N,size=s)
}



	




ddist<-function(x,y,z,r,x0,y0,z0){
	xdist<-abs((x0-x)) - r
	ydist<-abs((y0-y)) - r
#	zdist<-(z0-z) - r
zdist<-0
out<-xdist+ydist+zdist
out
}



translate<-function(data,x,y,z){
#data <- dataset containing x,y,z coordinates #
#x,y,z defines the translation #
data$x<-data$x+x
data$y<-data$y+y
data$z<-data$z+z
data<-as.data.frame(data)
data
}


### Takes in a dataset containing sphere centers and their radius and calculates the fractal dimension of the accessible volume ####
sphere2pix<-function(grid_size,center,radius){
## Create set of pixels centered at 0,0 ##
## Geneterate square with center pixel = 0,0 and sides = 2*r ##
pixels<-NULL
num_pix<-(2*radius/grid_size)
j<-1
for(x in 1:num_pix){
for(y in 1:num_pix){
for(z in 1:num_pix){
pixels$x[j]<-(x*grid_size)
pixels$y[j]<-(y*grid_size)
pixels$z[j]<-(z*grid_size)
pixels$filled[j]<-0
j<-j+1
}
}
}
pixels<-as.data.frame(pixels)
pixels<-translate(pixels,(-1*radius),(-1*radius),(-1*radius))
r<-dim(pixels)[1]
## Keep set of all pixels with centers that are < r from 0,0 ## 
for(i in c(1:r)){
dist<-sqrt(pixels$x[i]^2+pixels$y[i]^2+pixels$z[i]^2)
if(dist<radius){
pixels$filled[i]<-1
}	
}

center<-(round((center/grid_size))*grid_size - grid_size/2)
## Translate to closest pixel to center of the sphere ###
pixels<-translate(pixels,center[1],center[2],center[3])
pixels

}

pixelize<-function(spheres)
{
## This is the lenght of each pixel edge ##
grid_size<-0.5
## space size is the dimension of the space ##
space_size<-100
## Generate a dataset of all pixels (space_size/grid_size)^3
for(s in c(1:dim(spheres)[1])){


	
}

}




}
