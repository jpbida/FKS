source("functions.r")
datasets<-c("allborder1500.px",
"allborder3000.px",
"allborder4500.px",
"allborder16000.px",
"allborder32000.px",
"allborder48000.px",
)
path="~/projects/p1000/metrics/accVolume/data/2D/"
i<-1
size_space<-1000
for(dataset in datasets){
if(i > 3){
	size_space<-500
}
	fdim(paste(path,dataset,sep=""),dataset,0.976,size_space)
i<-i+1
}
#radius_1<-1
#dataset<-"test50.dat"
#source("fractdim.r")

#### Fractal Dimension r=2 ###
#radius_1<-2
#dataset<-"test25_2.dat"
#source("fractdim.r")
#dataset<-"test50_2.dat"
#source("fractdim.r")
#dataset<-"test75_2.dat"
#source("fractdim.r")
#dataset<-"test100_2.dat"
#source("fractdim.r")
#### Fractal Dimension r=3 ###
#radius_1<-3
#dataset<-"test25_3.dat"
#source("fractdim.r")
#dataset<-"test50_3.dat"
#source("fractdim.r")
#dataset<-"test75_3.dat"
#source("fractdim.r")
#dataset<-"test100_3.dat"
#source("fractdim.r")
#### Fractal Dimension r=4 ###
#radius_1<-4
#dataset<-"test25_4.dat"
#source("fractdim.r")
#dataset<-"test50_4.dat"
#source("fractdim.r")
#dataset<-"test75_4.dat"
#source("fractdim.r")
#dataset<-"test100_4.dat"
#source("fractdim.r")
